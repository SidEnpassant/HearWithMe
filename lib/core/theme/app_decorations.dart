import 'package:flutter/material.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';

/// Shared decoration presets for glassmorphism and themed containers.
abstract final class AppDecorations {
  /// Standard glassmorphic card decoration.
  static BoxDecoration glass({
    double borderRadius = UIConstants.radiusXLarge,
    double opacity = UIConstants.glassFillOpacity,
    double borderOpacity = UIConstants.glassBorderOpacity,
  }) {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: Colors.white.withValues(alpha: borderOpacity),
      ),
    );
  }

  /// Glass card with dark shadow for elevated elements.
  static BoxDecoration glassElevated({
    double borderRadius = UIConstants.radiusXLarge,
  }) {
    return BoxDecoration(
      color: AppColors.glassFill,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: AppColors.glassBorder),
      boxShadow: const [
        BoxShadow(
          color: AppColors.shadowDark,
          blurRadius: 32,
          offset: Offset(0, 8),
        ),
      ],
    );
  }

  /// Surface card (solid dark, no glass).
  static BoxDecoration surface({
    double borderRadius = UIConstants.radiusXLarge,
    Color color = AppColors.surfacePrimary,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  /// Orange accent gradient decoration for buttons.
  static BoxDecoration accentGradient({
    double borderRadius = UIConstants.radiusLarge,
  }) {
    return BoxDecoration(
      gradient: AppColors.accentGradient,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: AppColors.accentPrimary.withValues(alpha: 0.3),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Layered dark shadow for cards.
  static List<BoxShadow> get cardShadow => const [
        BoxShadow(
          color: AppColors.shadowDark,
          blurRadius: 32,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: AppColors.shadowDarker,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];
}
