import 'package:flutter/material.dart';

class MasterColors {
  MasterColors._();

  // Primitives Colors
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color transparent = Colors.transparent;
  // Theme Colors

  // Primary Sky Blue – buttons, app bar
  static Color primary = const Color(0xFF4A90E2);
  static Color primaryDark = const Color(0xFF2C3E50); // Night variant
  static Color primaryLight = const Color(0xFF5C9DED); // Rainy color

  // Light Aqua – for toggle accents, highlights
  static Color secondary = const Color(0xFF50E3C2);

  // Background and surface
  static Color background = const Color(0xFFF5F9FF);
  static Color cardBackground = white;

  static Color weatherSecondary = const Color(0xFFB0BEC5);
  static Color weatherPrimary = primary;
  // Text colors
  static Color textPrimary = const Color(0xFF1C1C1E);
  static Color textSecondary = const Color(0xFF6E6E73);

  // Error color for-specific UI
  static Color error = const Color(0xFFFF6B6B);

  // Accent colors for forecast icons
  static Color sun = const Color(0xFFFDB813);
  static Color rain = const Color(0xFF5C9DED);
  static Color night = const Color(0xFF2C3E50);
}
