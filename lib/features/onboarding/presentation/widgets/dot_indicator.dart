import 'package:flutter/material.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_colors.dart';

/// Animated dot indicator with morphing active dot (pill shape).
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    required this.count,
    required this.activeIndex,
    super.key,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final isActive = i == activeIndex;
        return AnimatedContainer(
          duration: UIConstants.durationMedium,
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstants.radiusCircular),
            color:
                isActive ? AppColors.accentPrimary : AppColors.surfaceTertiary,
          ),
        );
      }),
    );
  }
}
