import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTheme defines the complete Material 3 design system for AgriAssist
/// extracted directly from the Figma design specifications.
///
/// It provides standard color constants, typography, card shapes, button
/// themes, input styling, chips, app bar, and bottom navigation bar themes.
class AppTheme {
  // ==========================================
  // 1. Color Palette (Constants)
  // ==========================================

  // Primary & Secondary Greens
  static const Color primaryGreen = Color(0xFF14532D); // Deep forest green (#14532D)
  static const Color primaryGreenMedium = Color(0xFF166534); // Medium forest green (#166534)
  static const Color accentGreen = Color(0xFF22C55E); // Vibrant status green (#22C55E)
  static const Color mintContainer = Color(0xFFDCFCE7); // Light mint badge & button tint (#DCFCE7)
  static const Color mintBackground = mintContainer; // Alias for mint badge background
  static const Color softGreen = Color(0xFFE8F5E9); // Soft subtle card tint (#E8F5E9)

  // Background & Surface
  static const Color scaffoldBackground = Color(0xFFF3FAF4); // Fresh off-white canvas (#F3FAF4)
  static const Color surfaceWhite = Color(0xFFFFFFFF); // Clean pure white card surface (#FFFFFF)
  static const Color cardWhite = surfaceWhite; // Alias for card surface
  static const Color borderLight = Color(0xFFE2E8F0); // Subtle 1px card/input border (#E2E8F0)
  static const Color borderSubtle = Color(0xFFE5E7EB);

  // Typography & Text Colors
  static const Color textPrimary = Color(0xFF111827); // Dark charcoal for headlines & bold values
  static const Color textSecondary = Color(0xFF64748B); // Slate grey for subtitles & body
  static const Color textMuted = Color(0xFF94A3B8); // Light grey for timestamps & helpers

  // Status, Alert & Warning Colors
  static const Color warningOrange = Color(0xFFEA580C); // Attention / Alert orange text
  static const Color warningPeach = Color(0xFFFFF3E0); // Warm peach card & tag background
  static const Color warningBorder = Color(0xFFFED7AA);
  static const Color alertRed = Color(0xFFDC2626); // Disease alert & negative market trend
  static const Color alertRedBackground = Color(0xFFFEE2E2); // Disease alert badge background

  // ==========================================
  // 2. Material 3 ColorScheme
  // ==========================================

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryGreen,
    onPrimary: Colors.white,
    primaryContainer: mintContainer,
    onPrimaryContainer: primaryGreen,
    secondary: accentGreen,
    onSecondary: Colors.white,
    secondaryContainer: softGreen,
    onSecondaryContainer: primaryGreenMedium,
    surface: surfaceWhite,
    onSurface: textPrimary,
    error: alertRed,
    onError: Colors.white,
    errorContainer: alertRedBackground,
    onErrorContainer: alertRed,
    outline: borderLight,
    outlineVariant: borderSubtle,
  );

  // ==========================================
  // 3. ThemeData Definition
  // ==========================================

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,

      // --- Typography System ---
      textTheme: baseTextTheme.copyWith(
        // Screen Headlines & Display (e.g., "Good morning, Farmer!", "28°C", "92%")
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 34,
          letterSpacing: -0.5,
        ),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 24,
          letterSpacing: -0.3,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        // Section titles & Card headers (e.g., "Field Tools", "My Crops", "5-Day Forecast")
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          color: textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        // Body descriptions & advice paragraphs
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: textPrimary,
          fontSize: 14,
          height: 1.45,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: textSecondary,
          fontSize: 13,
          height: 1.4,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: textMuted,
          fontSize: 11,
        ),
        // Badges, chips, tags and small indicators
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: primaryGreen,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),

      // --- AppBar Theme ---
      appBarTheme: const AppBarTheme(
        backgroundColor: scaffoldBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(
          color: primaryGreen,
          size: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: primaryGreen,
          size: 24,
        ),
      ),

      // --- Card Theme ---
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: borderLight, width: 1),
        ),
      ),

      // --- Button Themes ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primaryGreen.withValues(alpha: 0.5),
          disabledForegroundColor: Colors.white70,
          elevation: 0,
          minimumSize: const Size.fromHeight(50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryGreen,
          backgroundColor: softGreen,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: borderLight, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryGreenMedium,
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: primaryGreen,
        ),
      ),

      // --- Input Field Theme ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceWhite,
        hintStyle: const TextStyle(
          color: textMuted,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryGreen, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: alertRed, width: 1),
        ),
      ),

      // --- Chip & FilterChip Theme ---
      chipTheme: ChipThemeData(
        backgroundColor: surfaceWhite,
        selectedColor: primaryGreen,
        disabledColor: scaffoldBackground,
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: borderLight, width: 1),
        ),
        checkmarkColor: Colors.white,
      ),

      // --- Bottom Navigation Bar Theme ---
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceWhite,
        elevation: 2,
        height: 70,
        indicatorColor: mintContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: primaryGreen,
              );
            }
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textSecondary,
            );
          },
        ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(
                color: primaryGreen,
                size: 24,
              );
            }
            return const IconThemeData(
              color: textSecondary,
              size: 24,
            );
          },
        ),
      ),

      // --- Progress Indicator Theme ---
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryGreen,
        linearTrackColor: borderLight,
        circularTrackColor: borderLight,
      ),

      // --- Divider Theme ---
      dividerTheme: const DividerThemeData(
        color: borderLight,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
