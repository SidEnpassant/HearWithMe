import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';
import 'package:hearwithme/core/widgets/glass_container.dart';

/// P2P Discovery page with animated radar and peer list.
class P2PDiscoveryPage extends StatefulWidget {
  const P2PDiscoveryPage({super.key});

  @override
  State<P2PDiscoveryPage> createState() => _P2PDiscoveryPageState();
}

class _P2PDiscoveryPageState extends State<P2PDiscoveryPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _radarController;
  bool _isScanning = true;

  static const _mockPeers = [
    _MockPeer('Alex', '🎸', 0.3, 0.25, PeerStatus.streaming),
    _MockPeer('Maya', '🎧', 0.7, 0.35, PeerStatus.online),
    _MockPeer('Sam', '🎵', 0.45, 0.65, PeerStatus.online),
    _MockPeer('Jo', '🎤', 0.8, 0.7, PeerStatus.idle),
  ];

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: UIConstants.spacing16),

              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Nearby',
                      style: AppTextStyles.displayMedium,
                    ),
                  ),
                  // Scan toggle
                  GestureDetector(
                    onTap: () {
                      setState(() => _isScanning = !_isScanning);
                      if (_isScanning) {
                        _radarController.repeat();
                      } else {
                        _radarController.stop();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _isScanning
                            ? AppColors.accentPrimary.withValues(alpha: 0.15)
                            : AppColors.surfacePrimary,
                        borderRadius: BorderRadius.circular(
                          UIConstants.radiusCircular,
                        ),
                        border: Border.all(
                          color: _isScanning
                              ? AppColors.accentPrimary
                              : AppColors.glassBorder,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isScanning)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.peerOnline,
                              ),
                            )
                                .animate(
                                  onPlay: (c) => c.repeat(reverse: true),
                                )
                                .fadeIn()
                                .then()
                                .fade(
                                  begin: 1,
                                  end: 0.3,
                                  duration: 800.ms,
                                ),
                          Text(
                            _isScanning ? 'Scanning' : 'Scan',
                            style: AppTextStyles.labelMedium.copyWith(
                              color: _isScanning
                                  ? AppColors.accentPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.1, end: 0),

              const SizedBox(height: UIConstants.spacing24),

              // Radar visualization
              Center(
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: AnimatedBuilder(
                    animation: _radarController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _RadarPainter(
                          progress: _radarController.value,
                          isScanning: _isScanning,
                        ),
                        child: child,
                      );
                    },
                    child: Stack(
                      children: [
                        // Center dot (self)
                        Center(
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentPrimary,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accentPrimary.withValues(
                                    alpha: 0.5,
                                  ),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Peer dots
                        ..._mockPeers.asMap().entries.map((e) {
                          final i = e.key;
                          final p = e.value;
                          return Positioned(
                            left: p.relX * 280 - 16,
                            top: p.relY * 280 - 16,
                            child: _PeerDot(peer: p, index: i),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: UIConstants.spacing32),

              // Peer list
              Text('Connected Peers', style: AppTextStyles.headlineMedium)
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: UIConstants.spacing12),

              ..._mockPeers.asMap().entries.map((e) {
                final i = e.key;
                final p = e.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: UIConstants.spacing8),
                  child: _PeerTile(peer: p, index: i),
                );
              }),

              const SizedBox(height: UIConstants.spacing32),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Radar Painter ──

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.progress, required this.isScanning});

  final double progress;
  final bool isScanning;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2;

    // Concentric circles
    for (var i = 1; i <= 3; i++) {
      canvas.drawCircle(
        center,
        maxR * (i / 3),
        Paint()
          ..color = AppColors.glassBorder
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8,
      );
    }

    // Sweep gradient (radar arm)
    if (isScanning) {
      final sweepAngle = progress * 2 * pi;
      final sweepPaint = Paint()
        ..shader = SweepGradient(
          startAngle: sweepAngle - 0.8,
          endAngle: sweepAngle,
          colors: [
            Colors.transparent,
            AppColors.accentPrimary.withValues(alpha: 0.15),
          ],
          tileMode: TileMode.decal,
        ).createShader(Rect.fromCircle(center: center, radius: maxR));

      canvas.drawCircle(center, maxR, sweepPaint);

      // Radar line
      final lineEnd = Offset(
        center.dx + maxR * cos(sweepAngle),
        center.dy + maxR * sin(sweepAngle),
      );
      canvas.drawLine(
        center,
        lineEnd,
        Paint()
          ..color = AppColors.accentPrimary.withValues(alpha: 0.4)
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(_RadarPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.isScanning != isScanning;
}

// ── Peer Dot ──

class _PeerDot extends StatelessWidget {
  const _PeerDot({required this.peer, required this.index});

  final _MockPeer peer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfacePrimary,
            border: Border.all(color: peer.status.color, width: 2),
            boxShadow: [
              BoxShadow(
                color: peer.status.color.withValues(alpha: 0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Text(peer.emoji, style: const TextStyle(fontSize: 14)),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 600 + index * 200), duration: 500.ms)
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          curve: Curves.elasticOut,
          delay: Duration(milliseconds: 600 + index * 200),
        );
  }
}

// ── Peer Tile ──

class _PeerTile extends StatelessWidget {
  const _PeerTile({required this.peer, required this.index});

  final _MockPeer peer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(UIConstants.spacing12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: peer.status.color.withValues(alpha: 0.1),
              border: Border.all(color: peer.status.color),
            ),
            child: Center(
              child: Text(peer.emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: UIConstants.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(peer.name, style: AppTextStyles.labelLarge),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: peer.status.color,
                      ),
                    ),
                    Text(peer.status.label, style: AppTextStyles.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          if (peer.status == PeerStatus.streaming)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.accentPrimary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(UIConstants.radiusCircular),
              ),
              child: Text(
                'Join',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.accentPrimary,
                ),
              ),
            )
          else
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
            ),
        ],
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 500 + index * 80),
          duration: 400.ms,
        )
        .slideX(begin: 0.1, end: 0);
  }
}

// ── Mock Data ──

enum PeerStatus {
  online('Online', AppColors.peerOnline),
  streaming('Streaming', AppColors.peerStreaming),
  idle('Idle', AppColors.peerIdle);

  const PeerStatus(this.label, this.color);
  final String label;
  final Color color;
}

class _MockPeer {
  const _MockPeer(this.name, this.emoji, this.relX, this.relY, this.status);
  final String name;
  final String emoji;
  final double relX;
  final double relY;
  final PeerStatus status;
}
