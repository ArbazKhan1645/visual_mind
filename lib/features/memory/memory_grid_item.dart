import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:visualmind/app_theme.dart';
import 'package:visualmind/entities/memory_entity/memory_entity.dart';

class MemoryGridItem extends StatelessWidget {
  final MemoryEntity memory;
  const MemoryGridItem({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        'memory-detail',
        pathParameters: {'id': memory.id},
        extra: memory,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
          color: AppColors.bg2,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(memory.thumbnailPath ?? memory.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.bg3,
                      child: const Icon(
                        Icons.image_rounded,
                        color: AppColors.textTertiary,
                        size: 32,
                      ),
                    ),
                  ),
                  // Type badge overlay
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _TypeIcon(type: memory.type),
                  ),
                  // Text indicator
                  if (memory.extractedText.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.text_fields_rounded,
                              size: 10,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${memory.extractedText.length}',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memory.title ?? _typeLabel(memory.type),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _timeAgo(memory.capturedAt),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(MemoryType t) =>
      t.name[0].toUpperCase() + t.name.substring(1).replaceAll('_', ' ');

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}';
  }
}

class _TypeIcon extends StatelessWidget {
  final MemoryType type;
  const _TypeIcon({required this.type});

  static const _data = {
    MemoryType.photo: (Icons.photo_camera_rounded, AppColors.info),
    MemoryType.document: (Icons.description_rounded, AppColors.warning),
    MemoryType.receipt: (Icons.receipt_rounded, AppColors.success),
    MemoryType.business_card: (Icons.badge_rounded, AppColors.accent),
    MemoryType.whiteboard: (Icons.dashboard_rounded, Color(0xFF06B6D4)),
    MemoryType.scene: (Icons.landscape_rounded, AppColors.textSecondary),
  };

  @override
  Widget build(BuildContext context) {
    final (icon, color) =
        _data[type] ?? (Icons.image_rounded, AppColors.textSecondary);
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}
