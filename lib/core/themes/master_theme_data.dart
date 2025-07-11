import 'package:flutter/material.dart';
import 'package:weather_forecast/core/master_colors.dart';
import 'package:weather_forecast/core/master_config.dart';

ThemeData themeData(
  ThemeData baseTheme,
) {
  return baseTheme.copyWith(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      displayMedium: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      displaySmall: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      headlineLarge: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      headlineMedium: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      headlineSmall: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      titleLarge: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      titleMedium: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      titleSmall: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      labelLarge: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      labelMedium: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      labelSmall: TextStyle(
          fontFamily: MasterConfig.default_font_family,
          color: MasterColors.textPrimary),
      bodyLarge: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      bodyMedium: TextStyle(
        color: MasterColors.textPrimary,
        fontFamily: MasterConfig.default_font_family,
      ),
      bodySmall: TextStyle(
        color: MasterColors.textPrimary,
        height: 1.5,
        fontFamily: MasterConfig.default_font_family,
      ),
    ),
  );
}
