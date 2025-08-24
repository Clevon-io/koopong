import 'package:flutter/material.dart';

/// App Spacing Constants
/// Centralizes all spacing/padding/margin values to maintain consistency
class AppSpacing {
  // Extra small spacing
  static const double xs = 4.0;
  
  // Small spacing  
  static const double sm = 8.0;
  
  // Medium spacing (most commonly used)
  static const double md = 16.0;
  
  // Large spacing
  static const double lg = 24.0;
  
  // Extra large spacing
  static const double xl = 32.0;
  
  // Extra extra large spacing
  static const double xxl = 48.0;
  
  // Common EdgeInsets for reuse
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);
  
  // Commonly used symmetric paddings
  static const EdgeInsets horizontalMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets verticalMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets horizontalSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets verticalSM = EdgeInsets.symmetric(vertical: sm);
  
  // Common margin values
  static const EdgeInsets marginMD = EdgeInsets.all(md);
  static const EdgeInsets marginBottom = EdgeInsets.only(bottom: md);
}