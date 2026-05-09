import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:visualmind/database/database_helper.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/entities/search_result_entity/search_result_entity.dart';
import 'package:visualmind/repositories/memory_repository.dart';
import 'package:visualmind/repositories/memory_repository_impl.dart';
import 'package:visualmind/services/mi_service.dart';

// ─── INFRASTRUCTURE ──────────────────────────────────────────────────────────

final databaseHelperProvider = Provider<DatabaseHelper>(
  (_) => DatabaseHelper.instance,
);

final mlServiceProvider = Provider<MlService>((_) => MlService.instance);

final memoryRepositoryProvider = Provider<MemoryRepository>((ref) {
  return MemoryRepositoryImpl(
    db: ref.watch(databaseHelperProvider),
    ml: ref.watch(mlServiceProvider),
  );
});

// ─── MEMORIES LIST ───────────────────────────────────────────────────────────

class MemoriesNotifier extends AsyncNotifier<List<MemoryEntity>> {
  @override
  Future<List<MemoryEntity>> build() async {
    return _fetchAll();
  }

  Future<List<MemoryEntity>> _fetchAll() {
    return ref.read(memoryRepositoryProvider).getAllMemories(limit: 100);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchAll);
  }

  Future<void> deleteMemory(String id) async {
    await ref.read(memoryRepositoryProvider).deleteMemory(id);
    await refresh();
  }

  Future<void> updateMemory(MemoryEntity memory) async {
    await ref.read(memoryRepositoryProvider).updateMemory(memory);
    await refresh();
  }
}

final memoriesProvider =
    AsyncNotifierProvider<MemoriesNotifier, List<MemoryEntity>>(
      MemoriesNotifier.new,
    );

// ─── MEMORY COUNT ────────────────────────────────────────────────────────────

final memoryCountProvider = FutureProvider<int>((ref) {
  return ref.watch(memoryRepositoryProvider).getMemoryCount();
});

// ─── MEMORY BY TYPE ──────────────────────────────────────────────────────────

final memoriesByTypeProvider =
    FutureProvider.family<List<MemoryEntity>, MemoryType>((ref, type) {
      return ref.watch(memoryRepositoryProvider).getMemoriesByType(type);
    });

// ─── SINGLE MEMORY ───────────────────────────────────────────────────────────

final singleMemoryProvider = FutureProvider.family<MemoryEntity?, String>((
  ref,
  id,
) {
  return ref.watch(memoryRepositoryProvider).getMemoryById(id);
});

// ─── SEARCH ──────────────────────────────────────────────────────────────────

final searchQueryProvider = StateProvider<String>((_) => '');
final searchModeProvider = StateProvider<String>(
  (_) => 'hybrid',
); // 'text', 'semantic', 'hybrid'

final searchResultsProvider = FutureProvider<List<SearchResultEntity>>((
  ref,
) async {
  final query = ref.watch(searchQueryProvider);
  final mode = ref.watch(searchModeProvider);

  if (query.trim().length < 2) return [];

  final repo = ref.read(memoryRepositoryProvider);

  switch (mode) {
    case 'text':
      return repo.textSearch(query);
    case 'semantic':
      return repo.semanticSearch(query);
    default:
      return repo.searchMemories(query);
  }
});

// ─── PROCESSING ──────────────────────────────────────────────────────────────

class ProcessingNotifier extends Notifier<ProcessingState> {
  @override
  ProcessingState build() => const ProcessingState.idle();

  Future<MemoryEntity?> processImage(dynamic imageFile) async {
    state = const ProcessingState.processing(
      progress: 0.0,
      stage: 'Starting...',
    );

    try {
      final repo = ref.read(memoryRepositoryProvider);

      // Listen to processing stream
      final sub = repo.processingStream.listen((progress) {
        state = ProcessingState.processing(
          progress: progress.progress,
          stage: progress.message ?? progress.stage,
        );
      });

      final memory = await repo.processAndIndex(imageFile);
      sub.cancel();

      state = ProcessingState.success(memory: memory);

      // Refresh memories list
      ref.invalidate(memoriesProvider);
      ref.invalidate(memoryCountProvider);

      return memory;
    } catch (e) {
      state = ProcessingState.error(message: e.toString());
      return null;
    }
  }

  void reset() => state = const ProcessingState.idle();
}

final processingProvider =
    NotifierProvider<ProcessingNotifier, ProcessingState>(
      ProcessingNotifier.new,
    );

// ─── PROCESSING STATE ────────────────────────────────────────────────────────

sealed class ProcessingState {
  const ProcessingState();

  const factory ProcessingState.idle() = ProcessingIdle;
  const factory ProcessingState.processing({
    required double progress,
    required String stage,
  }) = ProcessingInProgress;
  const factory ProcessingState.success({required MemoryEntity memory}) =
      ProcessingSuccess;
  const factory ProcessingState.error({required String message}) =
      ProcessingError;
}

class ProcessingIdle extends ProcessingState {
  const ProcessingIdle();
}

class ProcessingInProgress extends ProcessingState {
  final double progress;
  final String stage;
  const ProcessingInProgress({required this.progress, required this.stage});
}

class ProcessingSuccess extends ProcessingState {
  final MemoryEntity memory;
  const ProcessingSuccess({required this.memory});
}

class ProcessingError extends ProcessingState {
  final String message;
  const ProcessingError({required this.message});
}

// ─── FILTER ──────────────────────────────────────────────────────────────────

final selectedTypeFilterProvider = StateProvider<MemoryType?>((_) => null);

final filteredMemoriesProvider = Provider<AsyncValue<List<MemoryEntity>>>((
  ref,
) {
  final filter = ref.watch(selectedTypeFilterProvider);
  final memories = ref.watch(memoriesProvider);

  if (filter == null) return memories;

  return memories.whenData(
    (list) => list.where((m) => m.type == filter).toList(),
  );
});
