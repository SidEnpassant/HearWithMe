import 'package:flutter/material.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_decorations.dart';
import 'package:hearwithme/core/theme/app_text_styles.dart';

/// Primary action button with accent gradient and optional loading state.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.icon,
    this.isFullWidth = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    final Widget child = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else if (icon != null) ...[
          Icon(icon, color: Colors.white, size: UIConstants.iconSizeMedium),
          const SizedBox(width: UIConstants.spacing8),
        ],
        if (!isLoading || !isFullWidth)
          Text(
            text,
            style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
          ),
      ],
    );

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: AnimatedContainer(
        duration: UIConstants.durationFast,
        width: isFullWidth ? double.infinity : null,
        height: 56,
        decoration: isDisabled ? null : AppDecorations.accentGradient(),
        child: Material(
          color: isDisabled ? Colors.grey.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
          child: InkWell(
            onTap: isDisabled ? null : onPressed,
            borderRadius: BorderRadius.circular(UIConstants.radiusLarge),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: UIConstants.spacing24),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
