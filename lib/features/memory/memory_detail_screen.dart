import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visualmind/app_theme.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';
import 'package:visualmind/providers/memory_providers.dart';

class MemoryDetailScreen extends ConsumerWidget {
  final String memoryId;
  final MemoryEntity? memory;
  const MemoryDetailScreen({super.key, required this.memoryId, this.memory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoryAsync = memory != null
        ? AsyncValue.data(memory!)
        : ref.watch(singleMemoryProvider(memoryId));

    return memoryAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (m) {
        if (m == null) {
          return const Scaffold(body: Center(child: Text('Memory not found')));
        }
        return _MemoryDetailBody(memory: m);
      },
    );
  }
}

class _MemoryDetailBody extends ConsumerStatefulWidget {
  final MemoryEntity memory;
  const _MemoryDetailBody({required this.memory});

  @override
  ConsumerState<_MemoryDetailBody> createState() => _MemoryDetailBodyState();
}

class _MemoryDetailBodyState extends ConsumerState<_MemoryDetailBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  bool _isImageExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _deleteMemory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bg2,
        title: const Text('Delete Memory?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(memoriesProvider.notifier).deleteMemory(widget.memory.id);
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final memory = widget.memory;

    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Collapsible image header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.bg0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(
                      text: memory.title ?? 'Memory from VisualMind',
                      files: [XFile(memory.imagePath)],
                    ),
                  );
                },
                icon: const Icon(Icons.share_rounded),
              ),
              IconButton(
                onPressed: _deleteMemory,
                icon: const Icon(Icons.delete_rounded, color: AppColors.error),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () =>
                    setState(() => _isImageExpanded = !_isImageExpanded),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                  child: Image.file(
                    File(memory.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.bg2,
                      child: const Icon(
                        Icons.broken_image_rounded,
                        color: AppColors.textTertiary,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Memory info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          memory.title ?? _typeLabel(memory.type),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      _TypeBadge(type: memory.type),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatDate(memory.capturedAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  // Quick stats
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _StatChip(
                        icon: Icons.text_fields_rounded,
                        value: '${memory.extractedText.length}',
                        label: 'text blocks',
                      ),
                      const SizedBox(width: 8),
                      _StatChip(
                        icon: Icons.label_rounded,
                        value: '${memory.detectedLabels.length}',
                        label: 'labels',
                      ),
                      const SizedBox(width: 8),
                      _StatChip(
                        icon: Icons.category_rounded,
                        value: '${memory.detectedObjects.length}',
                        label: 'objects',
                      ),
                    ],
                  ),

                  // Tags
                  if (memory.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: memory.tags
                          .map((t) => _TagChip(tag: t))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Tabs
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabsDelegate(
              TabBar(
                controller: _tabs,
                labelColor: AppColors.accentLight,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.accent,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Extracted Text'),
                  Tab(text: 'Labels'),
                  Tab(text: 'Objects'),
                ],
              ),
            ),
          ),

          SliverFillRemaining(
            child: TabBarView(
              controller: _tabs,
              children: [
                _TextTab(blocks: memory.extractedText),
                _LabelsTab(labels: memory.detectedLabels),
                _ObjectsTab(objects: memory.detectedObjects),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(MemoryType t) =>
      t.name[0].toUpperCase() + t.name.substring(1);

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      return 'Today at ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
    }
    if (diff.inDays == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

// ─── TABS ────────────────────────────────────────────────────────────────────

class _TextTab extends StatelessWidget {
  final List<String> blocks;
  const _TextTab({required this.blocks});

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) {
      return const Center(
        child: Text(
          'No text detected',
          style: TextStyle(color: AppColors.textTertiary),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: blocks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bg2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                blocks[i],
                style: const TextStyle(fontSize: 13, height: 1.5),
              ),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: blocks[i]));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(
                Icons.copy_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabelsTab extends StatelessWidget {
  final List<String> labels;
  const _LabelsTab({required this.labels});

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) {
      return const Center(
        child: Text(
          'No labels detected',
          style: TextStyle(color: AppColors.textTertiary),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: labels.map((l) => _LabelChip(label: l)).toList(),
      ),
    );
  }
}

class _ObjectsTab extends StatelessWidget {
  final List<DetectedObject> objects;
  const _ObjectsTab({required this.objects});

  @override
  Widget build(BuildContext context) {
    if (objects.isEmpty) {
      return const Center(
        child: Text(
          'No objects detected',
          style: TextStyle(color: AppColors.textTertiary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: objects.length,
      itemBuilder: (context, i) {
        final obj = objects[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          tileColor: AppColors.bg2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.border, width: 0.5),
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentDim,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.category_rounded,
              color: AppColors.accentLight,
              size: 20,
            ),
          ),
          title: Text(
            obj.label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          trailing: Text(
            '${(obj.confidence * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.success,
              fontFamily: 'monospace',
            ),
          ),
        );
      },
    );
  }
}

// ─── HELPER WIDGETS ──────────────────────────────────────────────────────────

class _TypeBadge extends StatelessWidget {
  final MemoryType type;
  const _TypeBadge({required this.type});

  static const _colors = {
    MemoryType.photo: AppColors.info,
    MemoryType.document: AppColors.warning,
    MemoryType.receipt: AppColors.success,
    MemoryType.business_card: AppColors.accent,
    MemoryType.whiteboard: Color(0xFF06B6D4),
    MemoryType.scene: AppColors.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[type] ?? AppColors.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        type.name.replaceAll('_', ' '),
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.accent),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  const _TagChip({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.bg3,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '#$tag',
        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  final String label;
  const _LabelChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
      ),
    );
  }
}

class _TabsDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabsDelegate(this.tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.bg0, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_TabsDelegate old) => false;
}
