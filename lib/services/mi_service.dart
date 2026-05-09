import 'dart:io';
import 'dart:math';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart'
    hide DetectedObject;
import 'package:visualmind/entities/memory_entity/memory_entity.dart';

class MlService {
  static final MlService instance = MlService._internal();
  MlService._internal();

  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  late final ImageLabeler _imageLabeler = ImageLabeler(
    options: ImageLabelerOptions(confidenceThreshold: 0.65),
  );

  late final ObjectDetector _objectDetector = ObjectDetector(
    options: ObjectDetectorOptions(
      mode: DetectionMode.single,
      classifyObjects: true,
      multipleObjects: true,
    ),
  );

  bool _disposed = false;

  // ─── OCR ─────────────────────────────────────────────────────────────────────

  Future<List<String>> extractText(File imageFile) async {
    if (_disposed) return [];
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognized = await _textRecognizer.processImage(inputImage);

      // Split into meaningful blocks, filter short noise
      final blocks = recognized.blocks
          .map((b) => b.text.trim())
          .where((t) => t.length > 2)
          .toList();

      return blocks;
    } catch (e) {
      return [];
    }
  }

  // ─── IMAGE LABELING ──────────────────────────────────────────────────────────

  Future<List<String>> labelImage(File imageFile) async {
    if (_disposed) return [];
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final labels = await _imageLabeler.processImage(inputImage);

      return labels
          .where((l) => l.confidence > 0.65)
          .map((l) => l.label.toLowerCase())
          .toList();
    } catch (e) {
      return [];
    }
  }

  // ─── OBJECT DETECTION ────────────────────────────────────────────────────────

  Future<List<DetectedObject>> detectObjects(File imageFile) async {
    if (_disposed) return [];
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final objects = await _objectDetector.processImage(inputImage);

      return objects.map((obj) {
        final label = obj.labels.isNotEmpty
            ? obj.labels.reduce((a, b) => a.confidence > b.confidence ? a : b)
            : null;

        final bb = obj.boundingBox;
        return DetectedObject(
          label: label?.text ?? 'object',
          confidence: label?.confidence ?? 0.5,
          boundingBox: BoundingBox(
            left: bb.left,
            top: bb.top,
            right: bb.right,
            bottom: bb.bottom,
          ),
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // ─── MEMORY TYPE CLASSIFICATION ──────────────────────────────────────────────

  MemoryType classifyMemoryType({
    required List<String> labels,
    required List<String> extractedText,
    required List<DetectedObject> objects,
  }) {
    final allText = extractedText.join(' ').toLowerCase();
    final allLabels = labels.join(' ').toLowerCase();
    final objectLabels = objects.map((o) => o.label.toLowerCase()).join(' ');

    // Document detection
    if (allLabels.contains('document') ||
        allLabels.contains('paper') ||
        (extractedText.length > 5 && allText.split(' ').length > 20)) {
      // Receipt check
      if (allText.contains('total') ||
          allText.contains('receipt') ||
          allText.contains('invoice') ||
          allText.contains('amount')) {
        return MemoryType.receipt;
      }
      // Business card
      if (allText.contains('@') ||
          allText.contains('phone') ||
          allText.contains('email') ||
          allText.contains('www')) {
        return MemoryType.business_card;
      }
      return MemoryType.document;
    }

    // Whiteboard detection
    if (allLabels.contains('whiteboard') ||
        allLabels.contains('blackboard') ||
        objectLabels.contains('whiteboard')) {
      return MemoryType.whiteboard;
    }

    // Photo with objects
    if (objects.isNotEmpty && extractedText.isEmpty) {
      return MemoryType.photo;
    }

    return MemoryType.scene;
  }

  // ─── LIGHTWEIGHT TEXT EMBEDDING ──────────────────────────────────────────────
  //
  // We use a simple TF-IDF inspired bag-of-words embedding (128-dim).
  // For production, replace with TFLite MobileBERT or all-MiniLM model.
  // This gives us cosine similarity search without heavy model inference.

  List<double> generateTextEmbedding(List<String> textBlocks) {
    const dims = 128;
    final vector = List<double>.filled(dims, 0.0);

    if (textBlocks.isEmpty) return vector;

    final allWords = textBlocks
        .join(' ')
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 2)
        .toList();

    if (allWords.isEmpty) return vector;

    // Hash each word into the vector space (locality-sensitive hashing)
    for (final word in allWords) {
      final hash = _djb2Hash(word);
      for (int i = 0; i < 4; i++) {
        final idx = ((hash >> (i * 8)) & 0xFF) % dims;
        vector[idx] += 1.0 / allWords.length;
      }
    }

    // L2 normalize
    return _l2Normalize(vector);
  }

  List<double> generateQueryEmbedding(String query) {
    final words = query
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 1)
        .toList();

    return generateTextEmbedding(words);
  }

  double cosineSimilarity(List<double> a, List<double> b) {
    if (a.isEmpty || b.isEmpty || a.length != b.length) return 0.0;

    double dot = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    final denom = sqrt(normA) * sqrt(normB);
    return denom == 0 ? 0.0 : dot / denom;
  }

  // ─── PRIVATE HELPERS ─────────────────────────────────────────────────────────

  int _djb2Hash(String str) {
    int hash = 5381;
    for (int i = 0; i < str.length; i++) {
      hash = ((hash << 5) + hash) + str.codeUnitAt(i);
      hash = hash & 0xFFFFFFFF;
    }
    return hash;
  }

  List<double> _l2Normalize(List<double> vec) {
    final norm = sqrt(vec.fold(0.0, (acc, v) => acc + v * v));
    if (norm == 0) return vec;
    return vec.map((v) => v / norm).toList();
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _textRecognizer.close();
    _imageLabeler.close();
    _objectDetector.close();
  }
}
