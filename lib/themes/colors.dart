import 'package:flutter/material.dart';

/// App Color Constants
/// Centralizes all color definitions to avoid repetition and maintain consistency
class AppColors {
  // Primary colors
  static const Color primary = Color.fromARGB(255, 249, 189, 9);
  static const Color primaryLight = Color(0xFFFFF3CD);

  // Background colors
  static const Color background = Color(0xFFF9F9F9);
  static const Color surface = Colors.white;
  static const Color card = Colors.white;

  // Text colors
  static const Color textPrimary = Color(0xFF121212);
  static const Color textSecondary = Color(0xFF757575);

  // Border and divider colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Utility colors
  static const Color transparent = Colors.transparent;
  static const Color shadow = Color(0x1A000000);

  // Gray scale
  static Color grey50 = Colors.grey[50]!;
  static Color grey100 = Colors.grey[100]!;
  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;
  static Color grey700 = Colors.grey[700]!;
  static Color grey800 = Colors.grey[800]!;
  static Color grey900 = Colors.grey[900]!;

  // Opacity variations
  static Color primaryWithOpacity(double opacity) =>
      primary.withValues(alpha: opacity);
  static Color textPrimaryWithOpacity(double opacity) =>
      textPrimary.withValues(alpha: opacity);
  static Color textSecondaryWithOpacity(double opacity) =>
      textSecondary.withValues(alpha: opacity);
}
