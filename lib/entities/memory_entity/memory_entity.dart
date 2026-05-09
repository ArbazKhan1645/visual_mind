import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_entity.freezed.dart';
part 'memory_entity.g.dart';

// ignore: constant_identifier_names
enum MemoryType { photo, document, whiteboard, receipt, business_card, scene }

@freezed
abstract class MemoryEntity with _$MemoryEntity {
  const factory MemoryEntity({
    required String id,
    required String imagePath,
    required DateTime capturedAt,
    required MemoryType type,
    @Default([]) List<String> extractedText,
    @Default([]) List<String> detectedLabels,
    @Default([]) List<DetectedObject> detectedObjects,
    String? title,
    String? summary,
    @Default([]) List<String> tags,
    @Default([]) List<double> embedding,
    @Default(false) bool isIndexed,
    String? thumbnailPath,
  }) = _MemoryEntity;

  factory MemoryEntity.fromJson(Map<String, dynamic> json) =>
      _$MemoryEntityFromJson(json);
}

@freezed
abstract class DetectedObject with _$DetectedObject {
  const factory DetectedObject({
    required String label,
    required double confidence,
    required BoundingBox boundingBox,
  }) = _DetectedObject;

  factory DetectedObject.fromJson(Map<String, dynamic> json) =>
      _$DetectedObjectFromJson(json);
}

@freezed
abstract class BoundingBox with _$BoundingBox {
  const factory BoundingBox({
    required double left,
    required double top,
    required double right,
    required double bottom,
  }) = _BoundingBox;

  factory BoundingBox.fromJson(Map<String, dynamic> json) =>
      _$BoundingBoxFromJson(json);
}
