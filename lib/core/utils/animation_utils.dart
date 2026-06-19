import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';

/// Common animation presets using `flutter_animate`.
///
/// Designed to provide consistent UI feedback and transition
/// effects without repeating `.animate().fade().slide()` everywhere.
abstract final class AnimationUtils {
  /// Standard entrance animation (fade + slight slide up).
  static List<Effect<dynamic>> get entrance => const [
        FadeEffect(
          duration: UIConstants.durationMedium,
          curve: Curves.easeOut,
        ),
        SlideEffect(
          begin: Offset(0, 0.1),
          end: Offset.zero,
          duration: UIConstants.durationMedium,
          curve: Curves.easeOutCubic,
        ),
      ];

  /// Staggered entrance for list items.
  static List<Effect<dynamic>> staggeredEntrance(int index) => [
        FadeEffect(
          delay: Duration(milliseconds: index * UIConstants.staggerDelayMs),
          duration: UIConstants.durationMedium,
        ),
        SlideEffect(
          delay: Duration(milliseconds: index * UIConstants.staggerDelayMs),
          begin: const Offset(0, 0.2),
          end: Offset.zero,
          duration: UIConstants.durationMedium,
          curve: Curves.easeOutQuart,
        ),
      ];

  /// Gentle heartbeat pulse for active states (e.g., active mesh).
  static List<Effect<dynamic>> get pulse => const [
        ScaleEffect(
          begin: Offset(1, 1),
          end: Offset(1.05, 1.05),
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
        ),
      ];

  /// Shake effect for validation errors.
  static List<Effect<dynamic>> get shakeError => const [
        ShakeEffect(
          hz: 4,
          offset: Offset(10, 0),
          duration: UIConstants.durationMedium,
        ),
      ];
}

/// Extension on Widget to easily apply the preset animations.
extension AnimateWidgetExtension on Widget {
  Widget animateEntrance() {
    return animate(effects: AnimationUtils.entrance);
  }

  Widget animateStaggered(int index) {
    return animate(effects: AnimationUtils.staggeredEntrance(index));
  }

  Widget animatePulse() {
    return animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      effects: AnimationUtils.pulse,
    );
  }
}
