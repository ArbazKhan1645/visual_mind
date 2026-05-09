import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visualmind/app_theme.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/features/memory/memory_grid_item.dart';
import 'package:visualmind/providers/memory_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoriesAsync = ref.watch(filteredMemoriesProvider);
    final countAsync = ref.watch(memoryCountProvider);
    final filter = ref.watch(selectedTypeFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: AppColors.bg0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VisualMind',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                  ),
                ),
                countAsync.when(
                  data: (count) => Text(
                    '$count memories indexed',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => context.go('/search'),
                icon: const Icon(Icons.search_rounded),
              ),
              const SizedBox(width: 4),
            ],
          ),

          // Type filter chips
          SliverToBoxAdapter(child: _TypeFilterRow(selected: filter)),

          // Grid content
          memoriesAsync.when(
            loading: () => const SliverToBoxAdapter(child: ShimmerGrid()),
            error: (e, _) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: AppColors.error),
                  ),
                ),
              ),
            ),
            data: (memories) {
              if (memories.isEmpty) {
                return const SliverToBoxAdapter(child: HomeEmptyState());
              }
              return _MemoryGrid(memories: memories);
            },
          ),
        ],
      ),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: AppColors.bg2,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.photo_library_outlined,
            size: 72,
            color: AppColors.textTertiary,
          ),
          SizedBox(height: 24),
          Text(
            'No memories indexed yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Capture your first memory to see it appear here.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
// ─── TYPE FILTER ─────────────────────────────────────────────────────────────

class _TypeFilterRow extends ConsumerWidget {
  final MemoryType? selected;
  const _TypeFilterRow({this.selected});

  static const _types = [
    (null, 'All', Icons.apps_rounded),
    (MemoryType.photo, 'Photos', Icons.photo_rounded),
    (MemoryType.document, 'Docs', Icons.description_rounded),
    (MemoryType.receipt, 'Receipts', Icons.receipt_rounded),
    (MemoryType.whiteboard, 'Boards', Icons.dashboard_rounded),
    (MemoryType.business_card, 'Cards', Icons.badge_rounded),
    (MemoryType.scene, 'Scenes', Icons.landscape_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _types.length,
        separatorBuilder: (_, s) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (type, label, icon) = _types[i];
          final isActive = selected == type;
          return FilterChip(
            selected: isActive,
            onSelected: (_) =>
                ref.read(selectedTypeFilterProvider.notifier).state = type,
            avatar: Icon(icon, size: 14),
            label: Text(label),
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
            backgroundColor: AppColors.bg2,
            selectedColor: AppColors.accent,
            side: const BorderSide(color: AppColors.border, width: 0.5),
            showCheckmark: false,
            padding: const EdgeInsets.symmetric(horizontal: 4),
          );
        },
      ),
    );
  }
}

// ─── MEMORY GRID ─────────────────────────────────────────────────────────────

class _MemoryGrid extends StatelessWidget {
  final List<MemoryEntity> memories;
  const _MemoryGrid({required this.memories});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => MemoryGridItem(memory: memories[index])
              .animate(
                delay: Duration(milliseconds: (index * 40).clamp(0, 400)),
              )
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.1, duration: 300.ms),
          childCount: memories.length,
        ),
      ),
    );
  }
}
