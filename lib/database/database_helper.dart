import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:visualmind/entities/memory_entity/memory_entity.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _db;

  DatabaseHelper._internal();

  Future<void> init() async {
    _db ??= await _openDB();
  }

  Future<Database> get db async {
    _db ??= await _openDB();
    return _db!;
  }

  Future<Database> _openDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'visual_mind.db');

    return openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    // Memories table
    await db.execute('''
      CREATE TABLE memories (
        id TEXT PRIMARY KEY,
        image_path TEXT NOT NULL,
        thumbnail_path TEXT,
        captured_at INTEGER NOT NULL,
        type TEXT NOT NULL,
        extracted_text TEXT DEFAULT '[]',
        detected_labels TEXT DEFAULT '[]',
        detected_objects TEXT DEFAULT '[]',
        title TEXT,
        summary TEXT,
        tags TEXT DEFAULT '[]',
        embedding TEXT DEFAULT '[]',
        is_indexed INTEGER DEFAULT 0
      )
    ''');

    // FTS5 virtual table for full-text search
    await db.execute('''
      CREATE VIRTUAL TABLE memories_fts USING fts5(
        id UNINDEXED,
        extracted_text,
        detected_labels,
        title,
        summary,
        tags,
        content=memories,
        content_rowid=rowid
      )
    ''');

    // Triggers to keep FTS in sync
    await db.execute('''
      CREATE TRIGGER memories_ai AFTER INSERT ON memories BEGIN
        INSERT INTO memories_fts(rowid, id, extracted_text, detected_labels, title, summary, tags)
        VALUES (new.rowid, new.id, new.extracted_text, new.detected_labels, new.title, new.summary, new.tags);
      END
    ''');

    await db.execute('''
      CREATE TRIGGER memories_ad AFTER DELETE ON memories BEGIN
        INSERT INTO memories_fts(memories_fts, rowid, id, extracted_text, detected_labels, title, summary, tags)
        VALUES ('delete', old.rowid, old.id, old.extracted_text, old.detected_labels, old.title, old.summary, old.tags);
      END
    ''');

    await db.execute('''
      CREATE TRIGGER memories_au AFTER UPDATE ON memories BEGIN
        INSERT INTO memories_fts(memories_fts, rowid, id, extracted_text, detected_labels, title, summary, tags)
        VALUES ('delete', old.rowid, old.id, old.extracted_text, old.detected_labels, old.title, old.summary, old.tags);
        INSERT INTO memories_fts(rowid, id, extracted_text, detected_labels, title, summary, tags)
        VALUES (new.rowid, new.id, new.extracted_text, new.detected_labels, new.title, new.summary, new.tags);
      END
    ''');

    // Index on type and date
    await db.execute('CREATE INDEX idx_memories_type ON memories(type)');
    await db.execute(
      'CREATE INDEX idx_memories_date ON memories(captured_at DESC)',
    );
  }

  // ─── INSERT ──────────────────────────────────────────────────────────────────

  Future<void> insertMemory(MemoryEntity memory) async {
    final database = await db;
    await database.insert(
      'memories',
      _memoryToMap(memory),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ─── QUERIES ─────────────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> getAllMemories({
    int? limit,
    int? offset,
  }) async {
    final database = await db;
    return database.query(
      'memories',
      orderBy: 'captured_at DESC',
      limit: limit,
      offset: offset,
    );
  }

  Future<Map<String, dynamic>?> getMemoryById(String id) async {
    final database = await db;
    final results = await database.query(
      'memories',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<List<Map<String, dynamic>>> fullTextSearch(String query) async {
    final database = await db;
    // Sanitize query for FTS5
    final sanitized = query.replaceAll('"', '').trim();
    if (sanitized.isEmpty) return [];

    return database.rawQuery(
      '''
      SELECT m.*, bm25(memories_fts) as rank
      FROM memories m
      JOIN memories_fts ON m.id = memories_fts.id
      WHERE memories_fts MATCH ?
      ORDER BY rank
      LIMIT 50
    ''',
      ['"$sanitized"*'],
    );
  }

  Future<List<Map<String, dynamic>>> getMemoriesByType(String type) async {
    final database = await db;
    return database.query(
      'memories',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'captured_at DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getAllWithEmbeddings() async {
    final database = await db;
    return database.query(
      'memories',
      columns: [
        'id',
        'embedding',
        'image_path',
        'thumbnail_path',
        'captured_at',
        'type',
        'title',
      ],
      where: 'is_indexed = 1 AND embedding != "[]"',
    );
  }

  Future<int> getCount() async {
    final database = await db;
    final result = await database.rawQuery(
      'SELECT COUNT(*) as count FROM memories',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // ─── UPDATE ──────────────────────────────────────────────────────────────────

  Future<void> updateMemory(MemoryEntity memory) async {
    final database = await db;
    await database.update(
      'memories',
      _memoryToMap(memory),
      where: 'id = ?',
      whereArgs: [memory.id],
    );
  }

  // ─── DELETE ──────────────────────────────────────────────────────────────────

  Future<void> deleteMemory(String id) async {
    final database = await db;
    await database.delete('memories', where: 'id = ?', whereArgs: [id]);
  }

  // ─── HELPERS ─────────────────────────────────────────────────────────────────

  Map<String, dynamic> _memoryToMap(MemoryEntity memory) {
    return {
      'id': memory.id,
      'image_path': memory.imagePath,
      'thumbnail_path': memory.thumbnailPath,
      'captured_at': memory.capturedAt.millisecondsSinceEpoch,
      'type': memory.type.name,
      'extracted_text': jsonEncode(memory.extractedText),
      'detected_labels': jsonEncode(memory.detectedLabels),
      'detected_objects': jsonEncode(
        memory.detectedObjects.map((o) => o.toJson()).toList(),
      ),
      'title': memory.title,
      'summary': memory.summary,
      'tags': jsonEncode(memory.tags),
      'embedding': jsonEncode(memory.embedding),
      'is_indexed': memory.isIndexed ? 1 : 0,
    };
  }

  MemoryEntity mapToMemory(Map<String, dynamic> map) {
    return MemoryEntity(
      id: map['id'] as String,
      imagePath: map['image_path'] as String,
      thumbnailPath: map['thumbnail_path'] as String?,
      capturedAt: DateTime.fromMillisecondsSinceEpoch(
        map['captured_at'] as int,
      ),
      type: MemoryType.values.firstWhere(
        (t) => t.name == map['type'],
        orElse: () => MemoryType.scene,
      ),
      extractedText: List<String>.from(
        jsonDecode(map['extracted_text'] ?? '[]'),
      ),
      detectedLabels: List<String>.from(
        jsonDecode(map['detected_labels'] ?? '[]'),
      ),
      detectedObjects: (jsonDecode(map['detected_objects'] ?? '[]') as List)
          .map((o) => DetectedObject.fromJson(o as Map<String, dynamic>))
          .toList(),
      title: map['title'] as String?,
      summary: map['summary'] as String?,
      tags: List<String>.from(jsonDecode(map['tags'] ?? '[]')),
      embedding: List<double>.from(
        (jsonDecode(map['embedding'] ?? '[]') as List).map(
          (e) => (e as num).toDouble(),
        ),
      ),
      isIndexed: (map['is_indexed'] as int) == 1,
    );
  }
}
