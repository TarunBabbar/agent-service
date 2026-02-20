import 'package:flutter/material.dart';

ThemeData buildKrishnaTheme() {
  const green = Color(0xFF2E7D32);
  const white = Color(0xFFFFFFFF);
  const orange = Color(0xFFF57C00);
  const darkGray = Color(0xFF333333);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: green,
      primary: green,
      secondary: orange,
      surface: white,
      onSurface: darkGray,
    ),
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: green,
      foregroundColor: white,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkGray),
      bodyMedium: TextStyle(color: darkGray),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: green,
        foregroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: green),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
