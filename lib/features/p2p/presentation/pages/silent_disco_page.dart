import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';
import 'package:hearwithme/core/widgets/glass_container.dart';

/// Silent Disco Control Panel — host controls broadcast to peers.
class SilentDiscoPage extends StatefulWidget {
  const SilentDiscoPage({super.key});

  @override
  State<SilentDiscoPage> createState() => _SilentDiscoPageState();
}

class _SilentDiscoPageState extends State<SilentDiscoPage> {
  bool _isBroadcasting = false;
  double _volume = 0.75;

  static const _listeners = [
    _Listener('Alex', '🎸', true),
    _Listener('Maya', '🎧', true),
    _Listener('Sam', '🎵', true),
    _Listener('Jo', '🎤', false),
  ];

  @override
  Widget build(BuildContext context) {
    final connectedCount = _listeners.where((l) => l.isListening).length;
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
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Silent Disco',
                      style: AppTextStyles.displayMedium,
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.1, end: 0),

              const SizedBox(height: UIConstants.spacing24),

              // Broadcast toggle card
              GlassContainer(
                isElevated: true,
                padding: const EdgeInsets.all(UIConstants.spacing24),
                child: Column(
                  children: [
                    // Broadcast button
                    GestureDetector(
                      onTap: () => setState(
                        () => _isBroadcasting = !_isBroadcasting,
                      ),
                      child: AnimatedContainer(
                        duration: UIConstants.durationMedium,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: _isBroadcasting
                              ? AppColors.accentGradient
                              : null,
                          color: _isBroadcasting
                              ? null
                              : AppColors.surfaceTertiary,
                          boxShadow: _isBroadcasting
                              ? [
                                  BoxShadow(
                                    color: AppColors.accentPrimary.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          _isBroadcasting
                              ? Icons.cell_tower_rounded
                              : Icons.play_arrow_rounded,
                          size: 44,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacing16),
                    Text(
                      _isBroadcasting ? 'Broadcasting' : 'Start Broadcast',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: _isBroadcasting
                            ? AppColors.accentPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isBroadcasting
                          ? '$connectedCount listeners connected'
                          : 'Share your audio with nearby peers',
                      style: AppTextStyles.bodyMedium,
                    ),
                    if (_isBroadcasting) ...[
                      const SizedBox(height: UIConstants.spacing16),
                      // Pulsing ring indicator
                      ...List.generate(3, (i) {
                        return Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 180 + i * 30.0,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: AppColors.accentPrimary.withValues(
                              alpha: 0.3 - i * 0.08,
                            ),
                          ),
                        )
                            .animate(
                              onPlay: (c) => c.repeat(reverse: true),
                            )
                            .scaleX(
                              begin: 0.8,
                              end: 1.0,
                              duration: Duration(milliseconds: 1500 + i * 300),
                              curve: Curves.easeInOut,
                            );
                      }),
                    ],
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 500.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: UIConstants.spacing24),

              // Now playing card
              Container(
                padding: const EdgeInsets.all(UIConstants.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.surfacePrimary,
                  borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          UIConstants.radiusMedium,
                        ),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E88E5), Color(0xFF0D47A1)],
                        ),
                      ),
                      child: const Center(
                        child: Text('🌊', style: TextStyle(fontSize: 28)),
                      ),
                    ),
                    const SizedBox(width: UIConstants.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sunset Waves',
                            style: AppTextStyles.labelLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Luna Echo',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '1:18 / 3:42',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.accentPrimary,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 250.ms, duration: 400.ms),

              const SizedBox(height: UIConstants.spacing24),

              // Volume control
              Text('Volume', style: AppTextStyles.headlineMedium)
                  .animate()
                  .fadeIn(delay: 350.ms, duration: 400.ms),
              const SizedBox(height: UIConstants.spacing12),
              Container(
                padding: const EdgeInsets.all(UIConstants.spacing16),
                decoration: BoxDecoration(
                  color: AppColors.surfacePrimary,
                  borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.volume_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: AppColors.accentPrimary,
                          inactiveTrackColor: AppColors.surfaceTertiary,
                          thumbColor: AppColors.accentPrimary,
                          overlayColor: AppColors.accentPrimary.withValues(
                            alpha: 0.1,
                          ),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: _volume,
                          onChanged: (v) => setState(() => _volume = v),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.volume_up_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: UIConstants.spacing24),

              // Listener list
              Text('Listeners', style: AppTextStyles.headlineMedium)
                  .animate()
                  .fadeIn(delay: 450.ms, duration: 400.ms),
              const SizedBox(height: UIConstants.spacing12),

              ..._listeners.asMap().entries.map((entry) {
                final i = entry.key;
                final l = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: UIConstants.spacing8),
                  child: Container(
                    padding: const EdgeInsets.all(UIConstants.spacing12),
                    decoration: BoxDecoration(
                      color: AppColors.surfacePrimary,
                      borderRadius: BorderRadius.circular(
                        UIConstants.radiusMedium,
                      ),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: l.isListening
                                ? AppColors.peerOnline.withValues(alpha: 0.1)
                                : AppColors.surfaceTertiary,
                            border: Border.all(
                              color: l.isListening
                                  ? AppColors.peerOnline
                                  : AppColors.peerIdle,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              l.emoji,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: UIConstants.spacing12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.name, style: AppTextStyles.labelLarge),
                              Text(
                                l.isListening ? 'Listening' : 'Buffering...',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: l.isListening
                                      ? AppColors.peerOnline
                                      : AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Signal bars
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(4, (bar) {
                            final filled = bar < (l.isListening ? 3 : 1);
                            return Container(
                              width: 3,
                              height: 8.0 + bar * 3,
                              margin: const EdgeInsets.only(left: 2),
                              decoration: BoxDecoration(
                                color: filled
                                    ? AppColors.peerOnline
                                    : AppColors.surfaceTertiary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 500 + i * 80),
                        duration: 400.ms,
                      )
                      .slideX(begin: 0.1, end: 0),
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

class _Listener {
  const _Listener(this.name, this.emoji, this.isListening);
  final String name;
  final String emoji;
  final bool isListening;
}
