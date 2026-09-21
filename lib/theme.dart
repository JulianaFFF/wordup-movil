import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF6366B3);
  static const secondary = Color(0xFF14B8A6);
  static const highlight = Color(0xFFF4C95D);
  static const soft = Color(0xFFF8F7FF);
  static const error = Color(0xFFE8445A);
  static const black = Colors.black;
  static const white = Colors.white;
}

ThemeData buildTheme() {
  final textTheme = TextTheme(
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 64,
      fontWeight: FontWeight.w800,
      height: 80 / 64,
    ),

    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 40 / 48,
    ),

    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 35 / 32,
    ),

    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 30 / 24,
    ),

    bodyLarge: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 15 / 16,
    ),

    labelLarge: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 15 / 16,
    ),

    labelMedium: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 12 / 14,
    ),

    labelSmall: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 12 / 14,
    ),
  );


  return ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(color: AppColors.white, fontSize: 18),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.white),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.secondary
            : Colors.white38,
      ),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}
