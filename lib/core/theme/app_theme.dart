import 'package:flutter/material.dart';
import 'package:learnova/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: ColorManager.primary,
      scaffoldBackgroundColor: ColorManager.background,
      
      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: ColorManager.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: ColorManager.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ColorManager.textSecondary,
        ),
      ),

      // Input Decoration Theme (Text Fields)
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: ColorManager.textSecondary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        suffixIconColor: ColorManager.textSecondary,
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.white,
          foregroundColor: ColorManager.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: ColorManager.white,
      ),
    );
  }
}
