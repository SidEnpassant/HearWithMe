/// UI layout constants — spacing, radius, animation durations.
abstract final class UIConstants {
  // ── Spacing (4px base unit) ──
  static const spacing2 = 2.0;
  static const spacing4 = 4.0;
  static const spacing8 = 8.0;
  static const spacing12 = 12.0;
  static const spacing16 = 16.0;
  static const spacing20 = 20.0;
  static const spacing24 = 24.0;
  static const spacing32 = 32.0;
  static const spacing48 = 48.0;

  // ── Border Radius ──
  static const radiusSmall = 8.0;
  static const radiusMedium = 12.0;
  static const radiusLarge = 16.0;
  static const radiusXLarge = 20.0;
  static const radiusXXLarge = 28.0;
  static const radiusCircular = 999.0;

  // ── Animation Durations ──
  static const durationFast = Duration(milliseconds: 150);
  static const durationMedium = Duration(milliseconds: 300);
  static const durationSlow = Duration(milliseconds: 500);
  static const durationSlowest = Duration(milliseconds: 800);

  /// Staggered list item delay per index.
  static const staggerDelayMs = 60;

  // ── Sizing ──
  static const miniPlayerHeight = 64.0;
  static const bottomNavHeight = 72.0;
  static const iconSizeSmall = 18.0;
  static const iconSizeMedium = 24.0;
  static const iconSizeLarge = 32.0;

  /// Minimum interactive element size (Material guideline).
  static const minTapTarget = 48.0;

  // ── Glass Blur ──
  static const glassBlurSigma = 12.0;
  static const backgroundBlurSigma = 40.0;

  /// Glass fill opacity.
  static const glassFillOpacity = 0.06;

  /// Glass border opacity.
  static const glassBorderOpacity = 0.08;
}
