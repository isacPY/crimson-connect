import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // -----------------------------------------------------------------------------
  // Raw HSL-based Colors from CSS
  // --primary: 355 78% 56%;
  static final Color primary = HSLColor.fromAHSL(1.0, 355, 0.78, 0.56).toColor();
  // --primary-glow: 355 78% 70%;
  static final Color primaryGlow = HSLColor.fromAHSL(1.0, 355, 0.78, 0.70).toColor();
  
  // --destructive: 0 84.2% 60.2%;
  static final Color destructive = HSLColor.fromAHSL(1.0, 0, 0.842, 0.602).toColor();

  // Neutral Colors (Light)
  static const Color backgroundLight = Color(0xFFFCFCFC); // 0 0% 99%
  static const Color foregroundLight = Color(0xFF1F1F1F); // 0 0% 12%
  
  // Neutral Colors (Dark)
  static const Color backgroundDark = Color(0xFF0F0F0F); // 0 0% 6%
  static const Color foregroundDark = Color(0xFFF2F2F2); // 0 0% 95%

  // -----------------------------------------------------------------------------
  // Theme Data Factories
  // -----------------------------------------------------------------------------

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: const Color(0xFFF2F2F2), // --secondary: 0 15% 95%
        surface: const Color(0xFFFFFFFF), // --card: 100%
        error: destructive,
        onPrimary: Colors.white,
        onSurface: foregroundLight,
        outline: const Color(0xFFE5E5E5), // --border
      ),
      scaffoldBackgroundColor: backgroundLight,
      textTheme: GoogleFonts.dmSansTextTheme(ThemeData.light().textTheme).apply(
        bodyColor: foregroundLight,
        displayColor: foregroundLight,
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)), // --radius: 1rem
          side: BorderSide(color: Color(0xFFE5E5E5)), // border
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: const Color(0xFF262626), // --secondary: 0 10% 14%
        surface: const Color(0xFF171717), // --card: 0 0% 9%
        error: const Color(0xFFBB3232), // Adjusted for dark
        onPrimary: Colors.white,
        onSurface: foregroundDark,
        outline: const Color(0xFF2E2E2E), // --border
      ),
      scaffoldBackgroundColor: backgroundDark,
      textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: foregroundDark,
        displayColor: foregroundDark,
      ),
      cardTheme: const CardTheme(
        color: Color(0xFF171717),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: Color(0xFF2E2E2E)),
        ),
      ),
    );
  }
}
