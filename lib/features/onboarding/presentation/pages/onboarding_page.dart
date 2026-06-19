import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/app_constants.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';
import 'package:hearwithme/core/widgets/primary_button.dart';
import 'package:hearwithme/features/onboarding/presentation/widgets/display_name_input.dart';
import 'package:hearwithme/features/onboarding/presentation/widgets/dot_indicator.dart';
import 'package:hearwithme/features/onboarding/presentation/widgets/onboarding_slide.dart';
import 'package:go_router/go_router.dart';

/// 3-slide onboarding with compulsory display name on final slide.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  final _nameController = TextEditingController();
  int _currentPage = 0;
  String? _selectedEmoji;
  bool _nameValid = false;

  static const _emojis = [
    '🎧', '🎵', '🎸', '🎹', '🎷', '🎺', '🥁', '🎤',
    '🎶', '🎼', '🔊', '📻', '🎙️', '💿', '🪗', '🎻',
    '🦊', '🐱', '🐶', '🦁', '🐻', '🐼', '🦄', '🐸',
    '🌟', '⚡', '🔥', '🌊', '🌈', '🎃',
  ];

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _validateName() {
    final name = _nameController.text.trim();
    setState(() {
      _nameValid = name.length >= AppConstants.displayNameMinLength &&
          name.length <= AppConstants.displayNameMaxLength;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: UIConstants.durationMedium,
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onGetStarted() {
    if (!_nameValid) return;
    // TODO(Level4): Save identity to Isar
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          const _AnimatedBackground(),

          // Page content
          SafeArea(
            child: Column(
              children: [
                // Skip button (visible on slides 0-1)
                Align(
                  alignment: Alignment.topRight,
                  child: AnimatedOpacity(
                    opacity: _currentPage < 2 ? 1.0 : 0.0,
                    duration: UIConstants.durationFast,
                    child: Padding(
                      padding: const EdgeInsets.all(UIConstants.spacing16),
                      child: TextButton(
                        onPressed: _currentPage < 2
                            ? () => _pageController.animateToPage(
                                  2,
                                  duration: UIConstants.durationMedium,
                                  curve: Curves.easeOutCubic,
                                )
                            : null,
                        child: Text(
                          'Skip',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Slides
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [
                      // Slide 1
                      const OnboardingSlide(
                        icon: Icons.wifi_off_rounded,
                        iconColor: AppColors.accentPrimary,
                        title: 'Share Audio Offline',
                        subtitle:
                            'Stream music and podcasts to nearby\n'
                            'friends without internet — using\n'
                            'peer-to-peer mesh networking.',
                      ),

                      // Slide 2
                      const OnboardingSlide(
                        icon: Icons.library_music_rounded,
                        iconColor: AppColors.accentSecondary,
                        title: 'Discover Music & Podcasts',
                        subtitle:
                            'Browse 600K+ free songs from Jamendo,\n'
                            '4M+ podcasts from Podcast Index,\n'
                            'and Creative Commons audio worldwide.',
                      ),

                      // Slide 3 — Name entry
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: UIConstants.spacing24,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            // Headphone icon
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.accentPrimary.withValues(
                                      alpha: 0.2,
                                    ),
                                    AppColors.accentSecondary.withValues(
                                      alpha: 0.1,
                                    ),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.headphones_rounded,
                                size: 48,
                                color: AppColors.accentPrimary,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Sync & Listen Together',
                              style: AppTextStyles.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Set your display name to get started.\n'
                              "This is how you'll appear to nearby peers.",
                              style: AppTextStyles.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            // Display name input
                            DisplayNameInput(
                              controller: _nameController,
                              selectedEmoji: _selectedEmoji,
                              emojis: _emojis,
                              onEmojiSelected: (emoji) {
                                setState(() => _selectedEmoji = emoji);
                              },
                            ),
                            const SizedBox(height: 32),
                            PrimaryButton(
                              text: 'Get Started',
                              onPressed: _nameValid ? _onGetStarted : null,
                              icon: Icons.arrow_forward_rounded,
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Dot indicator + next button
                Padding(
                  padding: const EdgeInsets.only(
                    left: UIConstants.spacing24,
                    right: UIConstants.spacing24,
                    bottom: UIConstants.spacing32,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DotIndicator(
                        count: 3,
                        activeIndex: _currentPage,
                      ),
                      if (_currentPage < 2)
                        _NextButton(onTap: _nextPage)
                      else
                        const SizedBox(width: 56),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.accentGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.accentPrimary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
    ).animate().scale(
          delay: 400.ms,
          duration: 500.ms,
          curve: Curves.elasticOut,
        );
  }
}

/// Animated gradient background with floating orbs.
class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _OrbPainter(progress: _controller.value),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    // Dark background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = AppColors.scaffoldBg,
    );

    // Floating orange orbs
    final orbs = [
      _Orb(0.2, 0.3, 120, AppColors.accentPrimary.withValues(alpha: 0.06)),
      _Orb(0.8, 0.6, 160, AppColors.accentSecondary.withValues(alpha: 0.04)),
      _Orb(0.5, 0.8, 100, AppColors.accentPrimary.withValues(alpha: 0.05)),
    ];

    for (final orb in orbs) {
      final dx = orb.x * size.width + sin(progress * 2 * pi) * 30;
      final dy = orb.y * size.height + cos(progress * 2 * pi + 1) * 20;
      canvas.drawCircle(
        Offset(dx, dy),
        orb.radius,
        Paint()
          ..color = orb.color
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60),
      );
    }
  }

  @override
  bool shouldRepaint(_OrbPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _Orb {
  const _Orb(this.x, this.y, this.radius, this.color);
  final double x;
  final double y;
  final double radius;
  final Color color;
}
