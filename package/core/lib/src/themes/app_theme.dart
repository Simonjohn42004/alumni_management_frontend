import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // PRIMARY COLORS
  static const Color _primaryColor = Colors.purple;
  static const Color _primaryColorDark = Colors.purpleAccent;
  static const Color _secondaryColor = Colors.deepPurpleAccent;

  // COMMON TEXT STYLES
  static final TextTheme _baseTextTheme = TextTheme(
    displayLarge: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.pacifico(fontSize: 40),
    displaySmall: GoogleFonts.pacifico(fontSize: 28),
    headlineLarge: GoogleFonts.oswald(
      fontSize: 34,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.oswald(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.oswald(
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.oswald(fontSize: 30, fontStyle: FontStyle.italic),
    titleMedium: GoogleFonts.merriweather(fontSize: 20),
    titleSmall: GoogleFonts.merriweather(fontSize: 16),
    bodyLarge: GoogleFonts.merriweather(fontSize: 18),
    bodyMedium: GoogleFonts.merriweather(fontSize: 14),
    bodySmall: GoogleFonts.merriweather(fontSize: 12),
    labelLarge: GoogleFonts.oswald(fontSize: 14, fontWeight: FontWeight.w600),
    labelMedium: GoogleFonts.oswald(fontSize: 12),
    labelSmall: GoogleFonts.oswald(fontSize: 10),
  );

  /// Light Theme
  static ThemeData lightTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.light,
        primary: _primaryColor,
        secondary: _secondaryColor,
        surface: Colors.white,
        error: Colors.red.shade700,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onError: Colors.white,
      ),
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: Colors.white,
      textTheme: _baseTextTheme.apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: _baseTextTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          side: BorderSide(color: _primaryColor),
          textStyle: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        hintStyle: GoogleFonts.merriweather(color: Colors.grey.shade600),
        labelStyle: GoogleFonts.merriweather(color: Colors.grey.shade800),
        errorStyle: GoogleFonts.merriweather(color: Colors.red.shade700),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
      iconTheme: IconThemeData(color: _primaryColor),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _primaryColor,
        contentTextStyle: GoogleFonts.merriweather(
          color: Colors.white,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        contentTextStyle: GoogleFonts.merriweather(fontSize: 16),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _primaryColor,
        inactiveTrackColor: _primaryColor.withValues(alpha: 0.3),
        thumbColor: _primaryColor,
        overlayColor: _primaryColor.withValues(alpha: 0.3),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryColor;
          }
          return Colors.grey.shade400;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryColor.withValues(alpha: 0.6);
          }
          return Colors.grey.shade300;
        }),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: Colors.white,
        elevation: 10,
      ),

      // Add more as needed: checkboxTheme, radioTheme, tabBarTheme, scrollbarTheme, etc.
    );
  }

  /// Dark Theme
  static ThemeData darkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.dark,
        primary: _primaryColorDark,
        secondary: _secondaryColor,
        surface: Colors.grey.shade900,
        error: Colors.red.shade400,
        onPrimary: Colors.black87,
        onSecondary: Colors.white,
        onSurface: Colors.white70,
        onError: Colors.black87,
      ),
      primaryColor: _primaryColorDark,
      scaffoldBackgroundColor: Colors.black,
      textTheme: GoogleFonts.merriweatherTextTheme(
        base.textTheme,
      ).apply(bodyColor: Colors.white70, displayColor: Colors.white70),
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColorDark,
        foregroundColor: Colors.white,
        elevation: 4,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 3,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          side: BorderSide(color: _primaryColorDark),
          textStyle: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColorDark,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _primaryColorDark),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade800,
        hintStyle: GoogleFonts.merriweather(color: Colors.grey.shade400),
        labelStyle: GoogleFonts.merriweather(color: Colors.white70),
        errorStyle: GoogleFonts.merriweather(color: Colors.red.shade400),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
      iconTheme: IconThemeData(color: _primaryColorDark),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _primaryColorDark,
        contentTextStyle: GoogleFonts.merriweather(
          color: Colors.white,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white70,
        ),
        contentTextStyle: GoogleFonts.merriweather(
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _primaryColorDark,
        inactiveTrackColor: _primaryColorDark.withValues(alpha: 0.3),
        thumbColor: _primaryColorDark,
        overlayColor: _primaryColorDark.withValues(alpha: 0.3),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryColorDark;
          }
          return Colors.grey.shade700;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryColorDark.withValues(alpha: 0.6);
          }
          return Colors.grey.shade600;
        }),
      ),
      cardTheme: CardThemeData(
        color: Colors.grey.shade900,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(8),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _primaryColorDark,
        unselectedItemColor: Colors.grey.shade500,
        backgroundColor: Colors.grey.shade900,
        elevation: 10,
      ),

      // Add more customizations if desired
    );
  }
}
