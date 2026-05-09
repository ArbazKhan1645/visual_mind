// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemoryEntity {

 String get id; String get imagePath; DateTime get capturedAt; MemoryType get type; List<String> get extractedText; List<String> get detectedLabels; List<DetectedObject> get detectedObjects; String? get title; String? get summary; List<String> get tags; List<double> get embedding; bool get isIndexed; String? get thumbnailPath;
/// Create a copy of MemoryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoryEntityCopyWith<MemoryEntity> get copyWith => _$MemoryEntityCopyWithImpl<MemoryEntity>(this as MemoryEntity, _$identity);

  /// Serializes this MemoryEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.extractedText, extractedText)&&const DeepCollectionEquality().equals(other.detectedLabels, detectedLabels)&&const DeepCollectionEquality().equals(other.detectedObjects, detectedObjects)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.embedding, embedding)&&(identical(other.isIndexed, isIndexed) || other.isIndexed == isIndexed)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imagePath,capturedAt,type,const DeepCollectionEquality().hash(extractedText),const DeepCollectionEquality().hash(detectedLabels),const DeepCollectionEquality().hash(detectedObjects),title,summary,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(embedding),isIndexed,thumbnailPath);

@override
String toString() {
  return 'MemoryEntity(id: $id, imagePath: $imagePath, capturedAt: $capturedAt, type: $type, extractedText: $extractedText, detectedLabels: $detectedLabels, detectedObjects: $detectedObjects, title: $title, summary: $summary, tags: $tags, embedding: $embedding, isIndexed: $isIndexed, thumbnailPath: $thumbnailPath)';
}


}

/// @nodoc
abstract mixin class $MemoryEntityCopyWith<$Res>  {
  factory $MemoryEntityCopyWith(MemoryEntity value, $Res Function(MemoryEntity) _then) = _$MemoryEntityCopyWithImpl;
@useResult
$Res call({
 String id, String imagePath, DateTime capturedAt, MemoryType type, List<String> extractedText, List<String> detectedLabels, List<DetectedObject> detectedObjects, String? title, String? summary, List<String> tags, List<double> embedding, bool isIndexed, String? thumbnailPath
});




}
/// @nodoc
class _$MemoryEntityCopyWithImpl<$Res>
    implements $MemoryEntityCopyWith<$Res> {
  _$MemoryEntityCopyWithImpl(this._self, this._then);

  final MemoryEntity _self;
  final $Res Function(MemoryEntity) _then;

/// Create a copy of MemoryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imagePath = null,Object? capturedAt = null,Object? type = null,Object? extractedText = null,Object? detectedLabels = null,Object? detectedObjects = null,Object? title = freezed,Object? summary = freezed,Object? tags = null,Object? embedding = null,Object? isIndexed = null,Object? thumbnailPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MemoryType,extractedText: null == extractedText ? _self.extractedText : extractedText // ignore: cast_nullable_to_non_nullable
as List<String>,detectedLabels: null == detectedLabels ? _self.detectedLabels : detectedLabels // ignore: cast_nullable_to_non_nullable
as List<String>,detectedObjects: null == detectedObjects ? _self.detectedObjects : detectedObjects // ignore: cast_nullable_to_non_nullable
as List<DetectedObject>,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,embedding: null == embedding ? _self.embedding : embedding // ignore: cast_nullable_to_non_nullable
as List<double>,isIndexed: null == isIndexed ? _self.isIndexed : isIndexed // ignore: cast_nullable_to_non_nullable
as bool,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MemoryEntity].
extension MemoryEntityPatterns on MemoryEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MemoryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MemoryEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MemoryEntity value)  $default,){
final _that = this;
switch (_that) {
case _MemoryEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MemoryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MemoryEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imagePath,  DateTime capturedAt,  MemoryType type,  List<String> extractedText,  List<String> detectedLabels,  List<DetectedObject> detectedObjects,  String? title,  String? summary,  List<String> tags,  List<double> embedding,  bool isIndexed,  String? thumbnailPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MemoryEntity() when $default != null:
return $default(_that.id,_that.imagePath,_that.capturedAt,_that.type,_that.extractedText,_that.detectedLabels,_that.detectedObjects,_that.title,_that.summary,_that.tags,_that.embedding,_that.isIndexed,_that.thumbnailPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imagePath,  DateTime capturedAt,  MemoryType type,  List<String> extractedText,  List<String> detectedLabels,  List<DetectedObject> detectedObjects,  String? title,  String? summary,  List<String> tags,  List<double> embedding,  bool isIndexed,  String? thumbnailPath)  $default,) {final _that = this;
switch (_that) {
case _MemoryEntity():
return $default(_that.id,_that.imagePath,_that.capturedAt,_that.type,_that.extractedText,_that.detectedLabels,_that.detectedObjects,_that.title,_that.summary,_that.tags,_that.embedding,_that.isIndexed,_that.thumbnailPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imagePath,  DateTime capturedAt,  MemoryType type,  List<String> extractedText,  List<String> detectedLabels,  List<DetectedObject> detectedObjects,  String? title,  String? summary,  List<String> tags,  List<double> embedding,  bool isIndexed,  String? thumbnailPath)?  $default,) {final _that = this;
switch (_that) {
case _MemoryEntity() when $default != null:
return $default(_that.id,_that.imagePath,_that.capturedAt,_that.type,_that.extractedText,_that.detectedLabels,_that.detectedObjects,_that.title,_that.summary,_that.tags,_that.embedding,_that.isIndexed,_that.thumbnailPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MemoryEntity implements MemoryEntity {
  const _MemoryEntity({required this.id, required this.imagePath, required this.capturedAt, required this.type, final  List<String> extractedText = const [], final  List<String> detectedLabels = const [], final  List<DetectedObject> detectedObjects = const [], this.title, this.summary, final  List<String> tags = const [], final  List<double> embedding = const [], this.isIndexed = false, this.thumbnailPath}): _extractedText = extractedText,_detectedLabels = detectedLabels,_detectedObjects = detectedObjects,_tags = tags,_embedding = embedding;
  factory _MemoryEntity.fromJson(Map<String, dynamic> json) => _$MemoryEntityFromJson(json);

@override final  String id;
@override final  String imagePath;
@override final  DateTime capturedAt;
@override final  MemoryType type;
 final  List<String> _extractedText;
@override@JsonKey() List<String> get extractedText {
  if (_extractedText is EqualUnmodifiableListView) return _extractedText;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extractedText);
}

 final  List<String> _detectedLabels;
@override@JsonKey() List<String> get detectedLabels {
  if (_detectedLabels is EqualUnmodifiableListView) return _detectedLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedLabels);
}

 final  List<DetectedObject> _detectedObjects;
@override@JsonKey() List<DetectedObject> get detectedObjects {
  if (_detectedObjects is EqualUnmodifiableListView) return _detectedObjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_detectedObjects);
}

@override final  String? title;
@override final  String? summary;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<double> _embedding;
@override@JsonKey() List<double> get embedding {
  if (_embedding is EqualUnmodifiableListView) return _embedding;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_embedding);
}

@override@JsonKey() final  bool isIndexed;
@override final  String? thumbnailPath;

/// Create a copy of MemoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoryEntityCopyWith<_MemoryEntity> get copyWith => __$MemoryEntityCopyWithImpl<_MemoryEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemoryEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemoryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.capturedAt, capturedAt) || other.capturedAt == capturedAt)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._extractedText, _extractedText)&&const DeepCollectionEquality().equals(other._detectedLabels, _detectedLabels)&&const DeepCollectionEquality().equals(other._detectedObjects, _detectedObjects)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._embedding, _embedding)&&(identical(other.isIndexed, isIndexed) || other.isIndexed == isIndexed)&&(identical(other.thumbnailPath, thumbnailPath) || other.thumbnailPath == thumbnailPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imagePath,capturedAt,type,const DeepCollectionEquality().hash(_extractedText),const DeepCollectionEquality().hash(_detectedLabels),const DeepCollectionEquality().hash(_detectedObjects),title,summary,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_embedding),isIndexed,thumbnailPath);

@override
String toString() {
  return 'MemoryEntity(id: $id, imagePath: $imagePath, capturedAt: $capturedAt, type: $type, extractedText: $extractedText, detectedLabels: $detectedLabels, detectedObjects: $detectedObjects, title: $title, summary: $summary, tags: $tags, embedding: $embedding, isIndexed: $isIndexed, thumbnailPath: $thumbnailPath)';
}


}

/// @nodoc
abstract mixin class _$MemoryEntityCopyWith<$Res> implements $MemoryEntityCopyWith<$Res> {
  factory _$MemoryEntityCopyWith(_MemoryEntity value, $Res Function(_MemoryEntity) _then) = __$MemoryEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String imagePath, DateTime capturedAt, MemoryType type, List<String> extractedText, List<String> detectedLabels, List<DetectedObject> detectedObjects, String? title, String? summary, List<String> tags, List<double> embedding, bool isIndexed, String? thumbnailPath
});




}
/// @nodoc
class __$MemoryEntityCopyWithImpl<$Res>
    implements _$MemoryEntityCopyWith<$Res> {
  __$MemoryEntityCopyWithImpl(this._self, this._then);

  final _MemoryEntity _self;
  final $Res Function(_MemoryEntity) _then;

/// Create a copy of MemoryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imagePath = null,Object? capturedAt = null,Object? type = null,Object? extractedText = null,Object? detectedLabels = null,Object? detectedObjects = null,Object? title = freezed,Object? summary = freezed,Object? tags = null,Object? embedding = null,Object? isIndexed = null,Object? thumbnailPath = freezed,}) {
  return _then(_MemoryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,capturedAt: null == capturedAt ? _self.capturedAt : capturedAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MemoryType,extractedText: null == extractedText ? _self._extractedText : extractedText // ignore: cast_nullable_to_non_nullable
as List<String>,detectedLabels: null == detectedLabels ? _self._detectedLabels : detectedLabels // ignore: cast_nullable_to_non_nullable
as List<String>,detectedObjects: null == detectedObjects ? _self._detectedObjects : detectedObjects // ignore: cast_nullable_to_non_nullable
as List<DetectedObject>,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,embedding: null == embedding ? _self._embedding : embedding // ignore: cast_nullable_to_non_nullable
as List<double>,isIndexed: null == isIndexed ? _self.isIndexed : isIndexed // ignore: cast_nullable_to_non_nullable
as bool,thumbnailPath: freezed == thumbnailPath ? _self.thumbnailPath : thumbnailPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DetectedObject {

 String get label; double get confidence; BoundingBox get boundingBox;
/// Create a copy of DetectedObject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetectedObjectCopyWith<DetectedObject> get copyWith => _$DetectedObjectCopyWithImpl<DetectedObject>(this as DetectedObject, _$identity);

  /// Serializes this DetectedObject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectedObject&&(identical(other.label, label) || other.label == label)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,confidence,boundingBox);

@override
String toString() {
  return 'DetectedObject(label: $label, confidence: $confidence, boundingBox: $boundingBox)';
}


}

/// @nodoc
abstract mixin class $DetectedObjectCopyWith<$Res>  {
  factory $DetectedObjectCopyWith(DetectedObject value, $Res Function(DetectedObject) _then) = _$DetectedObjectCopyWithImpl;
@useResult
$Res call({
 String label, double confidence, BoundingBox boundingBox
});


$BoundingBoxCopyWith<$Res> get boundingBox;

}
/// @nodoc
class _$DetectedObjectCopyWithImpl<$Res>
    implements $DetectedObjectCopyWith<$Res> {
  _$DetectedObjectCopyWithImpl(this._self, this._then);

  final DetectedObject _self;
  final $Res Function(DetectedObject) _then;

/// Create a copy of DetectedObject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? confidence = null,Object? boundingBox = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,boundingBox: null == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox,
  ));
}
/// Create a copy of DetectedObject
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res> get boundingBox {
  
  return $BoundingBoxCopyWith<$Res>(_self.boundingBox, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}


/// Adds pattern-matching-related methods to [DetectedObject].
extension DetectedObjectPatterns on DetectedObject {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetectedObject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetectedObject() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetectedObject value)  $default,){
final _that = this;
switch (_that) {
case _DetectedObject():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetectedObject value)?  $default,){
final _that = this;
switch (_that) {
case _DetectedObject() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double confidence,  BoundingBox boundingBox)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetectedObject() when $default != null:
return $default(_that.label,_that.confidence,_that.boundingBox);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double confidence,  BoundingBox boundingBox)  $default,) {final _that = this;
switch (_that) {
case _DetectedObject():
return $default(_that.label,_that.confidence,_that.boundingBox);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double confidence,  BoundingBox boundingBox)?  $default,) {final _that = this;
switch (_that) {
case _DetectedObject() when $default != null:
return $default(_that.label,_that.confidence,_that.boundingBox);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetectedObject implements DetectedObject {
  const _DetectedObject({required this.label, required this.confidence, required this.boundingBox});
  factory _DetectedObject.fromJson(Map<String, dynamic> json) => _$DetectedObjectFromJson(json);

@override final  String label;
@override final  double confidence;
@override final  BoundingBox boundingBox;

/// Create a copy of DetectedObject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetectedObjectCopyWith<_DetectedObject> get copyWith => __$DetectedObjectCopyWithImpl<_DetectedObject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetectedObjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetectedObject&&(identical(other.label, label) || other.label == label)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.boundingBox, boundingBox) || other.boundingBox == boundingBox));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,confidence,boundingBox);

@override
String toString() {
  return 'DetectedObject(label: $label, confidence: $confidence, boundingBox: $boundingBox)';
}


}

/// @nodoc
abstract mixin class _$DetectedObjectCopyWith<$Res> implements $DetectedObjectCopyWith<$Res> {
  factory _$DetectedObjectCopyWith(_DetectedObject value, $Res Function(_DetectedObject) _then) = __$DetectedObjectCopyWithImpl;
@override @useResult
$Res call({
 String label, double confidence, BoundingBox boundingBox
});


@override $BoundingBoxCopyWith<$Res> get boundingBox;

}
/// @nodoc
class __$DetectedObjectCopyWithImpl<$Res>
    implements _$DetectedObjectCopyWith<$Res> {
  __$DetectedObjectCopyWithImpl(this._self, this._then);

  final _DetectedObject _self;
  final $Res Function(_DetectedObject) _then;

/// Create a copy of DetectedObject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? confidence = null,Object? boundingBox = null,}) {
  return _then(_DetectedObject(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,boundingBox: null == boundingBox ? _self.boundingBox : boundingBox // ignore: cast_nullable_to_non_nullable
as BoundingBox,
  ));
}

/// Create a copy of DetectedObject
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<$Res> get boundingBox {
  
  return $BoundingBoxCopyWith<$Res>(_self.boundingBox, (value) {
    return _then(_self.copyWith(boundingBox: value));
  });
}
}


/// @nodoc
mixin _$BoundingBox {

 double get left; double get top; double get right; double get bottom;
/// Create a copy of BoundingBox
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoundingBoxCopyWith<BoundingBox> get copyWith => _$BoundingBoxCopyWithImpl<BoundingBox>(this as BoundingBox, _$identity);

  /// Serializes this BoundingBox to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoundingBox&&(identical(other.left, left) || other.left == left)&&(identical(other.top, top) || other.top == top)&&(identical(other.right, right) || other.right == right)&&(identical(other.bottom, bottom) || other.bottom == bottom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,left,top,right,bottom);

@override
String toString() {
  return 'BoundingBox(left: $left, top: $top, right: $right, bottom: $bottom)';
}


}

/// @nodoc
abstract mixin class $BoundingBoxCopyWith<$Res>  {
  factory $BoundingBoxCopyWith(BoundingBox value, $Res Function(BoundingBox) _then) = _$BoundingBoxCopyWithImpl;
@useResult
$Res call({
 double left, double top, double right, double bottom
});




}
/// @nodoc
class _$BoundingBoxCopyWithImpl<$Res>
    implements $BoundingBoxCopyWith<$Res> {
  _$BoundingBoxCopyWithImpl(this._self, this._then);

  final BoundingBox _self;
  final $Res Function(BoundingBox) _then;

/// Create a copy of BoundingBox
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? left = null,Object? top = null,Object? right = null,Object? bottom = null,}) {
  return _then(_self.copyWith(
left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BoundingBox].
extension BoundingBoxPatterns on BoundingBox {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoundingBox value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoundingBox() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoundingBox value)  $default,){
final _that = this;
switch (_that) {
case _BoundingBox():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoundingBox value)?  $default,){
final _that = this;
switch (_that) {
case _BoundingBox() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double left,  double top,  double right,  double bottom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoundingBox() when $default != null:
return $default(_that.left,_that.top,_that.right,_that.bottom);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double left,  double top,  double right,  double bottom)  $default,) {final _that = this;
switch (_that) {
case _BoundingBox():
return $default(_that.left,_that.top,_that.right,_that.bottom);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double left,  double top,  double right,  double bottom)?  $default,) {final _that = this;
switch (_that) {
case _BoundingBox() when $default != null:
return $default(_that.left,_that.top,_that.right,_that.bottom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BoundingBox implements BoundingBox {
  const _BoundingBox({required this.left, required this.top, required this.right, required this.bottom});
  factory _BoundingBox.fromJson(Map<String, dynamic> json) => _$BoundingBoxFromJson(json);

@override final  double left;
@override final  double top;
@override final  double right;
@override final  double bottom;

/// Create a copy of BoundingBox
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoundingBoxCopyWith<_BoundingBox> get copyWith => __$BoundingBoxCopyWithImpl<_BoundingBox>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BoundingBoxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoundingBox&&(identical(other.left, left) || other.left == left)&&(identical(other.top, top) || other.top == top)&&(identical(other.right, right) || other.right == right)&&(identical(other.bottom, bottom) || other.bottom == bottom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,left,top,right,bottom);

@override
String toString() {
  return 'BoundingBox(left: $left, top: $top, right: $right, bottom: $bottom)';
}


}

/// @nodoc
abstract mixin class _$BoundingBoxCopyWith<$Res> implements $BoundingBoxCopyWith<$Res> {
  factory _$BoundingBoxCopyWith(_BoundingBox value, $Res Function(_BoundingBox) _then) = __$BoundingBoxCopyWithImpl;
@override @useResult
$Res call({
 double left, double top, double right, double bottom
});




}
/// @nodoc
class __$BoundingBoxCopyWithImpl<$Res>
    implements _$BoundingBoxCopyWith<$Res> {
  __$BoundingBoxCopyWithImpl(this._self, this._then);

  final _BoundingBox _self;
  final $Res Function(_BoundingBox) _then;

/// Create a copy of BoundingBox
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? left = null,Object? top = null,Object? right = null,Object? bottom = null,}) {
  return _then(_BoundingBox(
left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
