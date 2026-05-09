// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResultEntity {

 MemoryEntity get memory; double get relevanceScore; String get matchType;// 'semantic', 'text', 'label', 'hybrid'
 List<String> get matchedTerms; String? get snippet;
/// Create a copy of SearchResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultEntityCopyWith<SearchResultEntity> get copyWith => _$SearchResultEntityCopyWithImpl<SearchResultEntity>(this as SearchResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResultEntity&&(identical(other.memory, memory) || other.memory == memory)&&(identical(other.relevanceScore, relevanceScore) || other.relevanceScore == relevanceScore)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&const DeepCollectionEquality().equals(other.matchedTerms, matchedTerms)&&(identical(other.snippet, snippet) || other.snippet == snippet));
}


@override
int get hashCode => Object.hash(runtimeType,memory,relevanceScore,matchType,const DeepCollectionEquality().hash(matchedTerms),snippet);

@override
String toString() {
  return 'SearchResultEntity(memory: $memory, relevanceScore: $relevanceScore, matchType: $matchType, matchedTerms: $matchedTerms, snippet: $snippet)';
}


}

/// @nodoc
abstract mixin class $SearchResultEntityCopyWith<$Res>  {
  factory $SearchResultEntityCopyWith(SearchResultEntity value, $Res Function(SearchResultEntity) _then) = _$SearchResultEntityCopyWithImpl;
@useResult
$Res call({
 MemoryEntity memory, double relevanceScore, String matchType, List<String> matchedTerms, String? snippet
});


$MemoryEntityCopyWith<$Res> get memory;

}
/// @nodoc
class _$SearchResultEntityCopyWithImpl<$Res>
    implements $SearchResultEntityCopyWith<$Res> {
  _$SearchResultEntityCopyWithImpl(this._self, this._then);

  final SearchResultEntity _self;
  final $Res Function(SearchResultEntity) _then;

/// Create a copy of SearchResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memory = null,Object? relevanceScore = null,Object? matchType = null,Object? matchedTerms = null,Object? snippet = freezed,}) {
  return _then(_self.copyWith(
memory: null == memory ? _self.memory : memory // ignore: cast_nullable_to_non_nullable
as MemoryEntity,relevanceScore: null == relevanceScore ? _self.relevanceScore : relevanceScore // ignore: cast_nullable_to_non_nullable
as double,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as String,matchedTerms: null == matchedTerms ? _self.matchedTerms : matchedTerms // ignore: cast_nullable_to_non_nullable
as List<String>,snippet: freezed == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SearchResultEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemoryEntityCopyWith<$Res> get memory {
  
  return $MemoryEntityCopyWith<$Res>(_self.memory, (value) {
    return _then(_self.copyWith(memory: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchResultEntity].
extension SearchResultEntityPatterns on SearchResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _SearchResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MemoryEntity memory,  double relevanceScore,  String matchType,  List<String> matchedTerms,  String? snippet)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResultEntity() when $default != null:
return $default(_that.memory,_that.relevanceScore,_that.matchType,_that.matchedTerms,_that.snippet);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MemoryEntity memory,  double relevanceScore,  String matchType,  List<String> matchedTerms,  String? snippet)  $default,) {final _that = this;
switch (_that) {
case _SearchResultEntity():
return $default(_that.memory,_that.relevanceScore,_that.matchType,_that.matchedTerms,_that.snippet);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MemoryEntity memory,  double relevanceScore,  String matchType,  List<String> matchedTerms,  String? snippet)?  $default,) {final _that = this;
switch (_that) {
case _SearchResultEntity() when $default != null:
return $default(_that.memory,_that.relevanceScore,_that.matchType,_that.matchedTerms,_that.snippet);case _:
  return null;

}
}

}

/// @nodoc


class _SearchResultEntity implements SearchResultEntity {
  const _SearchResultEntity({required this.memory, required this.relevanceScore, required this.matchType, final  List<String> matchedTerms = const [], this.snippet}): _matchedTerms = matchedTerms;
  

@override final  MemoryEntity memory;
@override final  double relevanceScore;
@override final  String matchType;
// 'semantic', 'text', 'label', 'hybrid'
 final  List<String> _matchedTerms;
// 'semantic', 'text', 'label', 'hybrid'
@override@JsonKey() List<String> get matchedTerms {
  if (_matchedTerms is EqualUnmodifiableListView) return _matchedTerms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchedTerms);
}

@override final  String? snippet;

/// Create a copy of SearchResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultEntityCopyWith<_SearchResultEntity> get copyWith => __$SearchResultEntityCopyWithImpl<_SearchResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResultEntity&&(identical(other.memory, memory) || other.memory == memory)&&(identical(other.relevanceScore, relevanceScore) || other.relevanceScore == relevanceScore)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&const DeepCollectionEquality().equals(other._matchedTerms, _matchedTerms)&&(identical(other.snippet, snippet) || other.snippet == snippet));
}


@override
int get hashCode => Object.hash(runtimeType,memory,relevanceScore,matchType,const DeepCollectionEquality().hash(_matchedTerms),snippet);

@override
String toString() {
  return 'SearchResultEntity(memory: $memory, relevanceScore: $relevanceScore, matchType: $matchType, matchedTerms: $matchedTerms, snippet: $snippet)';
}


}

/// @nodoc
abstract mixin class _$SearchResultEntityCopyWith<$Res> implements $SearchResultEntityCopyWith<$Res> {
  factory _$SearchResultEntityCopyWith(_SearchResultEntity value, $Res Function(_SearchResultEntity) _then) = __$SearchResultEntityCopyWithImpl;
@override @useResult
$Res call({
 MemoryEntity memory, double relevanceScore, String matchType, List<String> matchedTerms, String? snippet
});


@override $MemoryEntityCopyWith<$Res> get memory;

}
/// @nodoc
class __$SearchResultEntityCopyWithImpl<$Res>
    implements _$SearchResultEntityCopyWith<$Res> {
  __$SearchResultEntityCopyWithImpl(this._self, this._then);

  final _SearchResultEntity _self;
  final $Res Function(_SearchResultEntity) _then;

/// Create a copy of SearchResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memory = null,Object? relevanceScore = null,Object? matchType = null,Object? matchedTerms = null,Object? snippet = freezed,}) {
  return _then(_SearchResultEntity(
memory: null == memory ? _self.memory : memory // ignore: cast_nullable_to_non_nullable
as MemoryEntity,relevanceScore: null == relevanceScore ? _self.relevanceScore : relevanceScore // ignore: cast_nullable_to_non_nullable
as double,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as String,matchedTerms: null == matchedTerms ? _self._matchedTerms : matchedTerms // ignore: cast_nullable_to_non_nullable
as List<String>,snippet: freezed == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SearchResultEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MemoryEntityCopyWith<$Res> get memory {
  
  return $MemoryEntityCopyWith<$Res>(_self.memory, (value) {
    return _then(_self.copyWith(memory: value));
  });
}
}

// dart format on
