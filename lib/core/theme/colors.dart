import 'package:flutter/material.dart';
import 'package:smartbudget/core/utils/cubit/home_cubit.dart';

class ColorsManager {
  // -------- MAIN PALETTE (Smart Budget Identity) -------- //
  static bool get isDarkMode => homeCubit.isDarkMode;
  // Primary: Trustworthy Blue/Purple
  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryDark = Color(
    0xFF6366F1,
  ); // Indigo 500 (For Dark Mode)

  // Secondary: Vibrant Accent
  static const Color secondary = Color(0xFF0EA5E9); // Sky Blue

  // -------- SEMANTIC COLORS (Budget Specific) -------- //
  static const Color income = Color(0xFF10B981); // Emerald Green
  static const Color expense = Color(0xFFEF4444); // Rose Red
  static const Color warning = Color(0xFFF59E0B); // Amber

  // -------- NEUTRALS (Light Theme) -------- //
  static const Color lightBackground = Color(0xFFF5F7FA); // Cool Light Grey
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF1F2937); // Gray 800
  static const Color lightTextSecondary = Color(0xFF6B7280); // Gray 500
  static const Color lightBorder = Color(0xFFE5E7EB); // Gray 200

  // -------- NEUTRALS (Dark Theme) -------- //
  static const Color darkBackground = Color(0xFF111827); // Gray 900
  static const Color darkSurface = Color(0xFF1F2937); // Gray 800
  static const Color darkTextPrimary = Color(0xFFF9FAFB); // Gray 50
  static const Color darkTextSecondary = Color(0xFF9CA3AF); // Gray 400
  static const Color darkBorder = Color(0xFF374151); // Gray 700

  // -------- GRADIENTS -------- //
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // -------- NEUTRALS (Dynamic) -------- //
  static Color get primaryColor => isDarkMode ? primaryDark : primary;
  static Color get backgroundColor =>
      isDarkMode ? darkBackground : lightBackground;
  static Color get textColor => isDarkMode ? darkTextPrimary : lightTextPrimary;
  static Color get textSecondaryColor =>
      isDarkMode ? darkTextSecondary : lightTextSecondary;
  static Color get cardColor => isDarkMode ? darkSurface : lightSurface;
}
