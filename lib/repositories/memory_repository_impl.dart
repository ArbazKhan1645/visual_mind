import 'dart:async';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:visualmind/database/database_helper.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/entities/search_result_entity/search_result_entity.dart';
import 'package:visualmind/repositories/memory_repository.dart';
import 'package:visualmind/services/mi_service.dart';

class MemoryRepositoryImpl implements MemoryRepository {
  final DatabaseHelper _db;
  final MlService _ml;
  final _uuid = const Uuid();

  final _processingController =
      StreamController<ProcessingProgress>.broadcast();

  MemoryRepositoryImpl({DatabaseHelper? db, MlService? ml})
    : _db = db ?? DatabaseHelper.instance,
      _ml = ml ?? MlService.instance;

  @override
  Stream<ProcessingProgress> get processingStream =>
      _processingController.stream;

  // ─── PROCESS & INDEX ─────────────────────────────────────────────────────────

  @override
  Future<MemoryEntity> processAndIndex(File imageFile) async {
    final id = _uuid.v4();
    final appDir = await getApplicationDocumentsDirectory();
    final memoriesDir = Directory(p.join(appDir.path, 'memories'));
    if (!await memoriesDir.exists()) await memoriesDir.create(recursive: true);

    // Copy original image
    final destPath = p.join(memoriesDir.path, '$id.jpg');
    await imageFile.copy(destPath);

    // Generate thumbnail
    _emit('ocr', 0.1, 'Generating thumbnail...');
    final thumbPath = await _generateThumbnail(imageFile, id, memoriesDir);

    // OCR
    _emit('ocr', 0.25, 'Reading text...');
    final extractedText = await _ml.extractText(imageFile);

    // Image labeling
    _emit('labeling', 0.45, 'Understanding scene...');
    final labels = await _ml.labelImage(imageFile);

    // Object detection
    _emit('labeling', 0.6, 'Detecting objects...');
    final objects = await _ml.detectObjects(imageFile);

    // Classify memory type
    final type = _ml.classifyMemoryType(
      labels: labels,
      extractedText: extractedText,
      objects: objects,
    );

    // Generate title from content
    final title = _generateTitle(extractedText, labels, type);

    // Generate embedding
    _emit('embedding', 0.8, 'Indexing for search...');
    final allText = [...extractedText, ...labels, title ?? ''];
    final embedding = _ml.generateTextEmbedding(allText);

    // Build entity
    final memory = MemoryEntity(
      id: id,
      imagePath: destPath,
      thumbnailPath: thumbPath,
      capturedAt: DateTime.now(),
      type: type,
      extractedText: extractedText,
      detectedLabels: labels,
      detectedObjects: objects,
      title: title,
      tags: _autoTags(labels, type),
      embedding: embedding,
      isIndexed: true,
    );

    // Save to DB
    _emit('saving', 0.95, 'Saving memory...');
    await _db.insertMemory(memory);

    _emit('saving', 1.0, 'Done!');
    return memory;
  }

  // ─── CRUD ─────────────────────────────────────────────────────────────────────

  @override
  Future<MemoryEntity> saveMemory(MemoryEntity memory) async {
    await _db.insertMemory(memory);
    return memory;
  }

  @override
  Future<List<MemoryEntity>> getAllMemories({int? limit, int? offset}) async {
    final rows = await _db.getAllMemories(limit: limit, offset: offset);
    return rows.map((r) => _db.mapToMemory(r)).toList();
  }

  @override
  Future<MemoryEntity?> getMemoryById(String id) async {
    final row = await _db.getMemoryById(id);
    return row != null ? _db.mapToMemory(row) : null;
  }

  @override
  Future<void> deleteMemory(String id) async {
    final memory = await getMemoryById(id);
    if (memory != null) {
      // Delete image files
      final imgFile = File(memory.imagePath);
      if (await imgFile.exists()) await imgFile.delete();
      if (memory.thumbnailPath != null) {
        final thumbFile = File(memory.thumbnailPath!);
        if (await thumbFile.exists()) await thumbFile.delete();
      }
    }
    await _db.deleteMemory(id);
  }

  @override
  Future<MemoryEntity> updateMemory(MemoryEntity memory) async {
    await _db.updateMemory(memory);
    return memory;
  }

  @override
  Future<List<MemoryEntity>> getMemoriesByType(MemoryType type) async {
    final rows = await _db.getMemoriesByType(type.name);
    return rows.map((r) => _db.mapToMemory(r)).toList();
  }

  @override
  Future<int> getMemoryCount() => _db.getCount();

  // ─── SEARCH ──────────────────────────────────────────────────────────────────

  @override
  Future<List<SearchResultEntity>> searchMemories(String query) async {
    if (query.trim().isEmpty) return [];

    // Run both searches in parallel
    final results = await Future.wait([
      textSearch(query),
      semanticSearch(query),
    ]);

    final textResults = results[0];
    final semanticResults = results[1];

    // Merge and deduplicate by ID, combining scores
    final merged = <String, SearchResultEntity>{};

    for (final r in textResults) {
      merged[r.memory.id] = r;
    }

    for (final r in semanticResults) {
      if (merged.containsKey(r.memory.id)) {
        // Combine scores: text match + semantic match = hybrid
        final existing = merged[r.memory.id]!;
        final combinedScore =
            (existing.relevanceScore * 0.6) + (r.relevanceScore * 0.4);
        merged[r.memory.id] = SearchResultEntity(
          memory: existing.memory,
          relevanceScore: combinedScore,
          matchType: 'hybrid',
          matchedTerms: {...existing.matchedTerms, ...r.matchedTerms}.toList(),
          snippet: existing.snippet ?? r.snippet,
        );
      } else {
        merged[r.memory.id] = r;
      }
    }

    final sorted = merged.values.toList()
      ..sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));

    return sorted.take(30).toList();
  }

  @override
  Future<List<SearchResultEntity>> textSearch(String query) async {
    final rows = await _db.fullTextSearch(query);
    return rows.map((row) {
      final memory = _db.mapToMemory(row);
      final rank = (row['rank'] as num?)?.toDouble() ?? -1.0;
      // BM25 returns negative values; closer to 0 = better
      final score = rank == 0 ? 0.0 : 1.0 / (1.0 + (-rank));

      // Find matching terms for highlighting
      final queryTerms = query.toLowerCase().split(' ');
      final allText = [
        ...memory.extractedText,
        ...memory.detectedLabels,
        memory.title ?? '',
      ].join(' ').toLowerCase();

      final matched = queryTerms.where((t) => allText.contains(t)).toList();
      final snippet = _buildSnippet(memory.extractedText, queryTerms);

      return SearchResultEntity(
        memory: memory,
        relevanceScore: score,
        matchType: 'text',
        matchedTerms: matched,
        snippet: snippet,
      );
    }).toList();
  }

  @override
  Future<List<SearchResultEntity>> semanticSearch(String query) async {
    final queryEmbedding = _ml.generateQueryEmbedding(query);
    if (queryEmbedding.every((v) => v == 0.0)) return [];

    final rows = await _db.getAllWithEmbeddings();

    final scored = <(double, Map<String, dynamic>)>[];
    for (final row in rows) {
      final memory = _db.mapToMemory(row);
      if (memory.embedding.isEmpty) continue;

      final similarity = _ml.cosineSimilarity(queryEmbedding, memory.embedding);
      if (similarity > 0.15) {
        scored.add((similarity, row));
      }
    }

    scored.sort((a, b) => b.$1.compareTo(a.$1));

    return scored.take(20).map((item) {
      final memory = _db.mapToMemory(item.$2);
      return SearchResultEntity(
        memory: memory,
        relevanceScore: item.$1,
        matchType: 'semantic',
        matchedTerms: [],
        snippet: null,
      );
    }).toList();
  }

  // ─── PRIVATE HELPERS ─────────────────────────────────────────────────────────

  Future<String?> _generateThumbnail(
    File imageFile,
    String id,
    Directory dir,
  ) async {
    try {
      final thumbPath = p.join(dir.path, '${id}_thumb.jpg');
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        thumbPath,
        quality: 70,
        minWidth: 400,
        minHeight: 400,
      );
      return result?.path;
    } catch (e) {
      return null;
    }
  }

  String? _generateTitle(
    List<String> extractedText,
    List<String> labels,
    MemoryType type,
  ) {
    switch (type) {
      case MemoryType.receipt:
        // Try to find store name (usually first line of receipt)
        if (extractedText.isNotEmpty) {
          final firstLine = extractedText.first.split('\n').first.trim();
          if (firstLine.length > 2 && firstLine.length < 40) return firstLine;
        }
        return 'Receipt';
      case MemoryType.business_card:
        // Usually first prominent text is the name
        if (extractedText.isNotEmpty) {
          return extractedText.first.split('\n').first.trim();
        }
        return 'Business Card';
      case MemoryType.whiteboard:
        return 'Whiteboard';
      case MemoryType.document:
        if (extractedText.isNotEmpty) {
          final firstLine = extractedText.first.split('\n').first.trim();
          if (firstLine.length > 3 && firstLine.length < 60) return firstLine;
        }
        return 'Document';
      case MemoryType.photo:
      case MemoryType.scene:
        if (labels.isNotEmpty) {
          return labels.take(2).map((l) => _capitalize(l)).join(', ');
        }
        return null;
    }
  }

  List<String> _autoTags(List<String> labels, MemoryType type) {
    final tags = <String>{type.name};
    tags.addAll(labels.take(5));
    return tags.toList();
  }

  String? _buildSnippet(List<String> textBlocks, List<String> queryTerms) {
    for (final block in textBlocks) {
      final lower = block.toLowerCase();
      if (queryTerms.any((t) => lower.contains(t))) {
        return block.length > 100 ? '${block.substring(0, 100)}...' : block;
      }
    }
    return textBlocks.isNotEmpty
        ? textBlocks.first.substring(0, textBlocks.first.length.clamp(0, 80))
        : null;
  }

  String _capitalize(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  void _emit(String stage, double progress, String message) {
    _processingController.add(
      ProcessingProgress(stage: stage, progress: progress, message: message),
    );
  }
}
