import 'package:flutter/material.dart';

/// Convenience extensions on [BuildContext] for quick access
/// to theme, colors, text styles, and media queries.
extension ContextExtensions on BuildContext {
  // ── Theme ──
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  // ── Media Query ──
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  double get bottomPadding => viewPadding.bottom;
  double get topPadding => viewPadding.top;

  // ── Responsive Breakpoints ──
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;

  // ── Navigation ──
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  // ── Snackbar ──
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
