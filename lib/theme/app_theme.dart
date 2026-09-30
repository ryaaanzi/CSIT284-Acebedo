import 'package:flutter/material.dart';

class AppTheme {
  static const background = Color(0xFF06110B);
  static const surface = Color(0xFF0B1C12);
  static const card = Color(0xFF102319);
  static const primary = Color(0xFF78FF8A);
  static const softGreen = Color(0xFFB8FFC0);
  static const mutedGreen = Color(0xFF83A18D);
  static const secondaryText = Color(0xFFA7B8AC);
  static const subtleText = Color(0xFF718579);
  static const border = Color(0xFF24422D);

  static const forestBackground = Color(0xFF0A1710);
  static const forestSurface = Color(0xFF10251A);
  static const forestCard = Color(0xFF163321);
  static const forestPrimary = Color(0xFF8CFF9A);
  static const forestBorder = Color(0xFF31563B);

  static ThemeData get darkTheme {
    return _buildTheme(
      background: background,
      surface: surface,
      card: card,
      primary: primary,
      border: border,
    );
  }

  static ThemeData get forestTheme {
    return _buildTheme(
      background: forestBackground,
      surface: forestSurface,
      card: forestCard,
      primary: forestPrimary,
      border: forestBorder,
    );
  }

  static ThemeData _buildTheme({
    required Color background,
    required Color surface,
    required Color card,
    required Color primary,
    required Color border,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary,
        surface: surface,
        onPrimary: background,
        onSecondary: background,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        labelStyle: const TextStyle(
          color: secondaryText,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF65796B),
        ),
        prefixIconColor: primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          color: secondaryText,
        ),
      ),
    );
  }
}