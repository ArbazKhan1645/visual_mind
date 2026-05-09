import 'dart:io';

import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/entities/search_result_entity/search_result_entity.dart';

abstract class MemoryRepository {
  /// Save a new memory after processing
  Future<MemoryEntity> saveMemory(MemoryEntity memory);

  /// Get all memories sorted by date desc
  Future<List<MemoryEntity>> getAllMemories({int? limit, int? offset});

  /// Get single memory by id
  Future<MemoryEntity?> getMemoryById(String id);

  /// Semantic + text hybrid search
  Future<List<SearchResultEntity>> searchMemories(String query);

  /// Text-only search (fast, no embedding)
  Future<List<SearchResultEntity>> textSearch(String query);

  /// Semantic search using vector similarity
  Future<List<SearchResultEntity>> semanticSearch(String query);

  /// Delete a memory and its associated files
  Future<void> deleteMemory(String id);

  /// Update memory tags / title
  Future<MemoryEntity> updateMemory(MemoryEntity memory);

  /// Get memories by type
  Future<List<MemoryEntity>> getMemoriesByType(MemoryType type);

  /// Get total memory count
  Future<int> getMemoryCount();

  /// Process and index image from camera
  Future<MemoryEntity> processAndIndex(File imageFile);

  /// Stream of new memories being processed
  Stream<ProcessingProgress> get processingStream;
}

class ProcessingProgress {
  final String stage; // 'ocr', 'labeling', 'embedding', 'saving'
  final double progress; // 0.0 to 1.0
  final String? message;

  const ProcessingProgress({
    required this.stage,
    required this.progress,
    this.message,
  });
}
