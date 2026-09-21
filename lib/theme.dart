import 'package:flutter/material.dart';

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
  return ThemeData(
    useMaterial3: true,
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
