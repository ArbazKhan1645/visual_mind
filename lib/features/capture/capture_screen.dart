import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visualmind/app_theme.dart';
import 'package:visualmind/providers/memory_providers.dart';

import '../../entities/memory_entity/memory_entity.dart';

class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isInitialized = false;
  bool _isCapturing = false;
  FlashMode _flashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      _controller = CameraController(
        _cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      if (mounted) setState(() => _isInitialized = true);
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (!_isInitialized || _isCapturing) return;
    setState(() => _isCapturing = true);

    try {
      final xFile = await _controller!.takePicture();
      final file = File(xFile.path);

      if (!mounted) return;

      // Show processing overlay
      _showProcessingSheet(file);
    } catch (e) {
      setState(() => _isCapturing = false);
      _showError('Capture failed: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (xFile == null) return;

    if (!mounted) return;
    _showProcessingSheet(File(xFile.path));
  }

  void _showProcessingSheet(File file) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProcessingSheet(imageFile: file),
    ).then((_) {
      setState(() => _isCapturing = false);
      if (mounted) context.pop();
    });
  }

  void _toggleFlash() {
    if (_controller == null) return;
    final next = _flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    setState(() => _flashMode = next);
    _controller!.setFlashMode(next);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview
          if (_isInitialized && _controller != null)
            CameraPreview(_controller!)
          else
            const Center(
              child: CircularProgressIndicator(color: AppColors.accentLight),
            ),

          // Top controls
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    _IconBtn(
                      icon: Icons.close_rounded,
                      onTap: () => context.pop(),
                    ),
                    const Spacer(),
                    _IconBtn(
                      icon: _flashMode == FlashMode.off
                          ? Icons.flash_off_rounded
                          : Icons.flash_on_rounded,
                      onTap: _toggleFlash,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Guide overlay
          Center(
            child: IgnorePointer(
              child:
                  Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.55,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.accentLight.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .fadeIn(duration: 1500.ms),
            ),
          ),

          // Hint text
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: const Text(
              'Point at anything to remember',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Gallery
                    _IconBtn(
                      icon: Icons.photo_library_rounded,
                      size: 44,
                      onTap: _pickFromGallery,
                    ),

                    // Shutter
                    GestureDetector(
                      onTap: _captureImage,
                      child: AnimatedContainer(
                        duration: 150.ms,
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accentLight,
                            width: 3,
                          ),
                          color: _isCapturing
                              ? AppColors.accentLight
                              : Colors.transparent,
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Flip camera
                    _cameras.length > 1
                        ? _IconBtn(
                            icon: Icons.flip_camera_android_rounded,
                            size: 44,
                            onTap: () async {
                              if (_cameras.length < 2) return;
                              final current = _controller!.description;
                              final next = _cameras.firstWhere(
                                (c) => c.lensDirection != current.lensDirection,
                                orElse: () => _cameras.first,
                              );
                              await _controller!.dispose();
                              _controller = CameraController(
                                next,
                                ResolutionPreset.high,
                                enableAudio: false,
                              );
                              await _controller!.initialize();
                              if (mounted) setState(() {});
                            },
                          )
                        : const SizedBox(width: 44),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── PROCESSING SHEET ────────────────────────────────────────────────────────

class _ProcessingSheet extends ConsumerStatefulWidget {
  final File imageFile;
  const _ProcessingSheet({required this.imageFile});

  @override
  ConsumerState<_ProcessingSheet> createState() => _ProcessingSheetState();
}

class _ProcessingSheetState extends ConsumerState<_ProcessingSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(processingProvider.notifier).processImage(widget.imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(processingProvider);

    ref.listen(processingProvider, (prev, next) {
      if (next is ProcessingSuccess) {
        final navigator = Navigator.of(context);
        Future.delayed(const Duration(milliseconds: 800), () {
          if (!mounted) return;
          ref.read(processingProvider.notifier).reset();
          navigator.pop();
        });
      }
    });

    return Container(
      height: 320,
      decoration: const BoxDecoration(
        color: AppColors.bg1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: switch (state) {
          ProcessingIdle() => const Center(child: CircularProgressIndicator()),
          ProcessingInProgress(progress: final p, stage: final s) =>
            _ProcessingView(progress: p, stage: s),
          ProcessingSuccess(memory: final m) => _SuccessView(memory: m),
          ProcessingError(message: final msg) => _ErrorView(message: msg),
        },
      ),
    );
  }
}

class _ProcessingView extends StatelessWidget {
  final double progress;
  final String stage;
  const _ProcessingView({required this.progress, required this.stage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Processing Memory',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          stage,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.bg3,
            color: AppColors.accentLight,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['OCR', 'Labels', 'Embedding', 'Index'].map((s) {
            final stageMap = {
              'OCR': 0.25,
              'Labels': 0.6,
              'Embedding': 0.8,
              'Index': 1.0,
            };
            final isDone = progress >= (stageMap[s] ?? 0);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Icon(
                    isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
                    size: 16,
                    color: isDone ? AppColors.success : AppColors.textTertiary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s,
                    style: TextStyle(
                      fontSize: 10,
                      color: isDone
                          ? AppColors.success
                          : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  final MemoryEntity memory;
  const _SuccessView({required this.memory});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 56,
        ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
        const SizedBox(height: 16),
        const Text(
          'Memory Saved!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          memory.title ?? _typeLabel(memory.type),
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 8),
        if (memory.extractedText.isNotEmpty)
          Text(
            '${memory.extractedText.length} text blocks extracted',
            style: const TextStyle(color: AppColors.accent, fontSize: 12),
          ),
        if (memory.detectedLabels.isNotEmpty)
          Text(
            '${memory.detectedLabels.length} labels detected',
            style: const TextStyle(color: AppColors.accent, fontSize: 12),
          ),
      ],
    );
  }

  String _typeLabel(MemoryType t) =>
      t.name[0].toUpperCase() + t.name.substring(1);
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_rounded, color: AppColors.error, size: 56),
        const SizedBox(height: 16),
        const Text(
          'Processing Failed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const _IconBtn({required this.icon, required this.onTap, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(size / 3),
          border: Border.all(color: Colors.white24, width: 0.5),
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
