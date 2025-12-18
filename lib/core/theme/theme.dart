import 'package:flutter/material.dart';
import 'package:smartbudget/core/theme/colors.dart';

class AppTheme {
  // ---------------- LIGHT THEME ---------------- //
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: ColorsManager.primary,
        secondary: ColorsManager.secondary,
        surface: ColorsManager.lightSurface,
        onSurface: ColorsManager.lightTextPrimary,
        error: ColorsManager.expense,
      ),
      scaffoldBackgroundColor: ColorsManager.lightBackground,

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ColorsManager.lightTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: ColorsManager.lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: ColorsManager.lightTextPrimary),
        bodyMedium: TextStyle(color: ColorsManager.lightTextSecondary),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorsManager.lightBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.lightTextPrimary),
        titleTextStyle: TextStyle(
          color: ColorsManager.lightTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: ColorsManager.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ColorsManager.lightBorder, width: 1),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.primary, width: 2),
        ),
        labelStyle: const TextStyle(color: ColorsManager.lightTextSecondary),
      ),
    );
  }

  // ---------------- DARK THEME ---------------- //
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: ColorsManager.primaryDark,
        secondary: ColorsManager.secondary,
        surface: ColorsManager.darkSurface,
        onSurface: ColorsManager.darkTextPrimary,
        error: ColorsManager.expense,
      ),
      scaffoldBackgroundColor: ColorsManager.darkBackground,

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: ColorsManager.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: ColorsManager.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: ColorsManager.darkTextPrimary),
        bodyMedium: TextStyle(color: ColorsManager.darkTextSecondary),
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorsManager.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.darkTextPrimary),
        titleTextStyle: TextStyle(
          color: ColorsManager.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: ColorsManager.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: ColorsManager.darkBorder, width: 1),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.primaryDark,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorsManager.primaryDark,
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(color: ColorsManager.darkTextSecondary),
      ),
    );
  }
}
