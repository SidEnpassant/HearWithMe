import 'package:flutter/material.dart';

/// HearWithMe color palette — dark-first, OLED-optimized.
///
/// Design DNA: Dark glassmorphism with burnt orange accents,
/// inspired by premium smart home UIs.
abstract final class AppColors {
  // ── Primary Surfaces ──
  static const scaffoldBg = Color(0xFF0A0A0A); // True dark
  static const surfacePrimary = Color(0xFF141414); // Card backgrounds
  static const surfaceSecondary = Color(0xFF1E1E1E); // Elevated surfaces
  static const surfaceTertiary = Color(0xFF2A2A2A); // Input fields

  // ── Accent — Burnt Orange ──
  static const accentPrimary = Color(0xFFFF5722); // Deep orange
  static const accentSecondary = Color(0xFFFF8A50); // Light orange
  static const accentGradient = LinearGradient(
    colors: [accentPrimary, accentSecondary],
  );
  static const accentGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accentPrimary, accentSecondary],
  );

  // ── Text Hierarchy ──
  static const textPrimary = Color(0xFFF5F5F5); // 96% white
  static const textSecondary = Color(0xFFB0B0B0); // 69% white
  static const textTertiary = Color(0xFF707070); // 44% white
  static const textOnAccent = Color(0xFFFFFFFF);

  // ── Semantic ──
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFB74D);
  static const error = Color(0xFFEF5350);
  static const info = Color(0xFF42A5F5);

  // ── Glass ──
  static const glassFill = Color(0x0FFFFFFF); // 6% white
  static const glassBorder = Color(0x14FFFFFF); // 8% white
  static const glassHighlight = Color(0x1AFFFFFF); // 10% white — hover state

  // ── Peer Status ──
  static const peerOnline = Color(0xFF4CAF50);
  static const peerStreaming = Color(0xFFFF5722);
  static const peerIdle = Color(0xFF707070);

  // ── Shadows ──
  static const shadowDark = Color(0x66000000); // 40% black
  static const shadowDarker = Color(0x99000000); // 60% black
}
