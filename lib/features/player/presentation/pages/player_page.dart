import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Full-screen immersive audio player with album art,
/// waveform scrubber, and playback controls.
class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _progress = 0.35;
  bool _isShuffled = false;
  int _repeatMode = 0; // 0=off, 1=all, 2=one
  bool _isLiked = false;

  late final AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _rotateController.repeat();
    } else {
      _rotateController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Blurred background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1E88E5).withValues(alpha: 0.3),
                  AppColors.scaffoldBg,
                  AppColors.scaffoldBg,
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top bar
                _TopBar(onClose: () => Navigator.of(context).pop())
                    .animate()
                    .fadeIn(duration: 400.ms),

                const Spacer(),

                // Album art with vinyl rotation
                _AlbumArt(controller: _rotateController, isPlaying: _isPlaying)
                    .animate()
                    .fadeIn(delay: 150.ms, duration: 600.ms)
                    .scale(
                      begin: const Offset(0.85, 0.85),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                    ),

                const SizedBox(height: 36),

                // Track info
                _TrackInfo(
                  isLiked: _isLiked,
                  onLikeToggle: () =>
                      setState(() => _isLiked = !_isLiked),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 400.ms)
                    .slideY(begin: 0.1, end: 0),

                const SizedBox(height: 28),

                // Waveform scrubber
                _WaveformScrubber(
                  progress: _progress,
                  onChanged: (v) => setState(() => _progress = v),
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms),

                const SizedBox(height: 8),

                // Time labels
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: UIConstants.spacing32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1:18', style: AppTextStyles.labelSmall),
                      Text('3:42', style: AppTextStyles.labelSmall),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Playback controls
                _PlaybackControls(
                  isPlaying: _isPlaying,
                  isShuffled: _isShuffled,
                  repeatMode: _repeatMode,
                  onPlayPause: _togglePlay,
                  onShuffle: () =>
                      setState(() => _isShuffled = !_isShuffled),
                  onRepeat: () =>
                      setState(() => _repeatMode = (_repeatMode + 1) % 3),
                  onPrevious: () {},
                  onNext: () {},
                )
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 400.ms)
                    .slideY(begin: 0.15, end: 0),

                const SizedBox(height: 24),

                // Bottom actions
                const _BottomActions()
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 400.ms),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Top Bar ──

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UIConstants.spacing16,
        vertical: UIConstants.spacing8,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textPrimary,
              size: 30,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                'PLAYING FROM',
                style: AppTextStyles.labelSmall.copyWith(
                  letterSpacing: 1.5,
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Jamendo · Trending',
                style: AppTextStyles.labelMedium,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Album Art with Vinyl Rotation ──

class _AlbumArt extends StatelessWidget {
  const _AlbumArt({required this.controller, required this.isPlaying});

  final AnimationController controller;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.7;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow behind
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E88E5).withValues(alpha: 0.25),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),

          // Album art
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.value * 2 * pi,
                child: child,
              );
            },
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E88E5),
                    Color(0xFF0D47A1),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Vinyl grooves
                  ...List.generate(4, (i) {
                    return Container(
                      width: size * (0.4 + i * 0.15),
                      height: size * (0.4 + i * 0.15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                    );
                  }),
                  // Center emoji
                  const Text('🌊', style: TextStyle(fontSize: 64)),
                  // Center hole
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.scaffoldBg.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Track Info ──

class _TrackInfo extends StatelessWidget {
  const _TrackInfo({required this.isLiked, required this.onLikeToggle});

  final bool isLiked;
  final VoidCallback onLikeToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunset Waves',
                  style: AppTextStyles.headlineLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Luna Echo',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onLikeToggle,
            icon: AnimatedSwitcher(
              duration: UIConstants.durationFast,
              child: Icon(
                isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey(isLiked),
                color: isLiked ? AppColors.accentPrimary : AppColors.textSecondary,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Waveform Scrubber ──

class _WaveformScrubber extends StatelessWidget {
  const _WaveformScrubber({required this.progress, required this.onChanged});

  final double progress;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing32),
      child: SizedBox(
        height: 48,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return GestureDetector(
              onHorizontalDragUpdate: (d) {
                final newProgress = (d.localPosition.dx / width).clamp(0.0, 1.0);
                onChanged(newProgress);
              },
              onTapDown: (d) {
                final newProgress = (d.localPosition.dx / width).clamp(0.0, 1.0);
                onChanged(newProgress);
              },
              child: CustomPaint(
                painter: _WaveformPainter(progress: progress),
                size: Size(width, 48),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  _WaveformPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final barCount = 60;
    final barWidth = size.width / barCount * 0.6;
    final spacing = size.width / barCount;
    final random = Random(42); // Seeded for consistent waveform

    for (var i = 0; i < barCount; i++) {
      final x = i * spacing + spacing / 2;
      final amplitude = 0.2 + random.nextDouble() * 0.8;
      final barHeight = amplitude * size.height * 0.8;
      final y = (size.height - barHeight) / 2;

      final isPlayed = x / size.width <= progress;
      final paint = Paint()
        ..color = isPlayed
            ? AppColors.accentPrimary
            : AppColors.surfaceTertiary
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - barWidth / 2, y, barWidth, barHeight),
          const Radius.circular(2),
        ),
        paint,
      );
    }

    // Progress indicator dot
    final dotX = progress * size.width;
    canvas.drawCircle(
      Offset(dotX, size.height / 2),
      6,
      Paint()..color = AppColors.accentPrimary,
    );
    canvas.drawCircle(
      Offset(dotX, size.height / 2),
      3,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_WaveformPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ── Playback Controls ──

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({
    required this.isPlaying,
    required this.isShuffled,
    required this.repeatMode,
    required this.onPlayPause,
    required this.onShuffle,
    required this.onRepeat,
    required this.onPrevious,
    required this.onNext,
  });

  final bool isPlaying;
  final bool isShuffled;
  final int repeatMode;
  final VoidCallback onPlayPause;
  final VoidCallback onShuffle;
  final VoidCallback onRepeat;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Shuffle
          IconButton(
            onPressed: onShuffle,
            icon: Icon(
              Icons.shuffle_rounded,
              color: isShuffled
                  ? AppColors.accentPrimary
                  : AppColors.textTertiary,
              size: 24,
            ),
          ),

          // Previous
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(
              Icons.skip_previous_rounded,
              color: AppColors.textPrimary,
              size: 36,
            ),
          ),

          // Play/Pause (large)
          GestureDetector(
            onTap: onPlayPause,
            child: AnimatedContainer(
              duration: UIConstants.durationFast,
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.accentGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentPrimary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: UIConstants.durationFast,
                child: Icon(
                  isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  key: ValueKey(isPlaying),
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),

          // Next
          IconButton(
            onPressed: onNext,
            icon: const Icon(
              Icons.skip_next_rounded,
              color: AppColors.textPrimary,
              size: 36,
            ),
          ),

          // Repeat
          IconButton(
            onPressed: onRepeat,
            icon: Icon(
              repeatMode == 2
                  ? Icons.repeat_one_rounded
                  : Icons.repeat_rounded,
              color: repeatMode > 0
                  ? AppColors.accentPrimary
                  : AppColors.textTertiary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom Actions ──

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionIcon(icon: Icons.cell_tower_rounded, label: 'Broadcast'),
          _ActionIcon(icon: Icons.download_rounded, label: 'Download'),
          _ActionIcon(icon: Icons.queue_music_rounded, label: 'Queue'),
          _ActionIcon(icon: Icons.share_rounded, label: 'Share'),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 22),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }
}
