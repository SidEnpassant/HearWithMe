import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hearwithme/core/constants/ui_constants.dart';
import 'package:hearwithme/core/theme/app_decorations.dart';

/// Reusable glassmorphic container widget.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    required this.child,
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(UIConstants.spacing16),
    this.margin,
    this.borderRadius = UIConstants.radiusXLarge,
    this.isElevated = false,
    this.opacity = UIConstants.glassFillOpacity,
    this.blurSigma = UIConstants.glassBlurSigma,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final bool isElevated;
  final double opacity;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: isElevated
          ? AppDecorations.glassElevated(borderRadius: borderRadius)
          : null, // If elevated, we don't blur the background (it casts shadow)
      child: isElevated
          ? _buildContent()
          : ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(
                  decoration: AppDecorations.glass(
                    borderRadius: borderRadius,
                    opacity: opacity,
                  ),
                  child: _buildContent(),
                ),
              ),
            ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
