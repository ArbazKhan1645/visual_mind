// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemoryEntity _$MemoryEntityFromJson(Map<String, dynamic> json) =>
    _MemoryEntity(
      id: json['id'] as String,
      imagePath: json['imagePath'] as String,
      capturedAt: DateTime.parse(json['capturedAt'] as String),
      type: $enumDecode(_$MemoryTypeEnumMap, json['type']),
      extractedText:
          (json['extractedText'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      detectedLabels:
          (json['detectedLabels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      detectedObjects:
          (json['detectedObjects'] as List<dynamic>?)
              ?.map((e) => DetectedObject.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      embedding:
          (json['embedding'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      isIndexed: json['isIndexed'] as bool? ?? false,
      thumbnailPath: json['thumbnailPath'] as String?,
    );

Map<String, dynamic> _$MemoryEntityToJson(_MemoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'capturedAt': instance.capturedAt.toIso8601String(),
      'type': _$MemoryTypeEnumMap[instance.type]!,
      'extractedText': instance.extractedText,
      'detectedLabels': instance.detectedLabels,
      'detectedObjects': instance.detectedObjects,
      'title': instance.title,
      'summary': instance.summary,
      'tags': instance.tags,
      'embedding': instance.embedding,
      'isIndexed': instance.isIndexed,
      'thumbnailPath': instance.thumbnailPath,
    };

const _$MemoryTypeEnumMap = {
  MemoryType.photo: 'photo',
  MemoryType.document: 'document',
  MemoryType.whiteboard: 'whiteboard',
  MemoryType.receipt: 'receipt',
  MemoryType.business_card: 'business_card',
  MemoryType.scene: 'scene',
};

_DetectedObject _$DetectedObjectFromJson(Map<String, dynamic> json) =>
    _DetectedObject(
      label: json['label'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      boundingBox: BoundingBox.fromJson(
        json['boundingBox'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$DetectedObjectToJson(_DetectedObject instance) =>
    <String, dynamic>{
      'label': instance.label,
      'confidence': instance.confidence,
      'boundingBox': instance.boundingBox,
    };

_BoundingBox _$BoundingBoxFromJson(Map<String, dynamic> json) => _BoundingBox(
  left: (json['left'] as num).toDouble(),
  top: (json['top'] as num).toDouble(),
  right: (json['right'] as num).toDouble(),
  bottom: (json['bottom'] as num).toDouble(),
);

Map<String, dynamic> _$BoundingBoxToJson(_BoundingBox instance) =>
    <String, dynamic>{
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
    };
