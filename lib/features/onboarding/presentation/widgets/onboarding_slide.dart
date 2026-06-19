import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Single onboarding slide with icon, title, and subtitle.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
    this.iconColor = AppColors.accentPrimary,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Glowing icon container
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  iconColor.withValues(alpha: 0.15),
                  iconColor.withValues(alpha: 0.02),
                ],
              ),
            ),
            child: Icon(icon, size: 56, color: iconColor),
          )
              .animate()
              .scale(
                delay: 200.ms,
                duration: 600.ms,
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: 400.ms),

          const SizedBox(height: 48),

          // Title
          Text(
            title,
            style: AppTextStyles.displayMedium,
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuart),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuart),
        ],
      ),
    );
  }
}
