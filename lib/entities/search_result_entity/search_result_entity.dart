import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';

part 'search_result_entity.freezed.dart';

@freezed
abstract class SearchResultEntity with _$SearchResultEntity {
  const factory SearchResultEntity({
    required MemoryEntity memory,
    required double relevanceScore,
    required String matchType, // 'semantic', 'text', 'label', 'hybrid'
    @Default([]) List<String> matchedTerms,
    String? snippet,
  }) = _SearchResultEntity;
}
