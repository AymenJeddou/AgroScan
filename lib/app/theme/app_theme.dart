import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Light palette ────────────────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF1F5A3C);
  static const Color secondaryColor = Color(0xFFEAF4EC);
  static const Color accentColor = Color(0xFFD2893B);
  static const Color backgroundColor = Color(0xFFF7F3EA);
  static const Color textColor = Color(0xFF1E2A24);
  static const Color mutedTextColor = Color(0xFF58665C);
  static const Color strokeColor = Color(0xFFE7E1D4);
  static const Color cardColor = Color(0xFFFFFDF9);
  static const Color shadowColor = Color(0x14000000);

  // ── Dark palette ─────────────────────────────────────────────────────────
  static const Color darkBackgroundColor = Color(0xFF111A15);
  static const Color darkCardColor = Color(0xFF1A2820);
  static const Color darkTextColor = Color(0xFFE8F0EA);
  static const Color darkMutedTextColor = Color(0xFF7A9A85);
  static const Color darkStrokeColor = Color(0xFF2A3D32);
  static const Color darkSecondaryColor = Color(0xFF1E3028);
  static const Color darkShadowColor = Color(0x40000000);

  // ── Light gradients ──────────────────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFF8F1E2), Color(0xFFEFF6F0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFBF3), Color(0xFFFFF7EA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient navGradient = LinearGradient(
    colors: [Color(0xFFFDF7EA), Color(0xFFF5F2E8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Dark gradients ───────────────────────────────────────────────────────
  static const LinearGradient darkHeroGradient = LinearGradient(
    colors: [Color(0xFF111A15), Color(0xFF172213)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF1A2820), Color(0xFF17241C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkNavGradient = LinearGradient(
    colors: [Color(0xFF161E19), Color(0xFF111A14)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Danger level colors ──────────────────────────────────────────────────
  static const Color dangerLow = Color(0xFF3E9E5A);
  static const Color dangerMedium = Color(0xFFF29D38);
  static const Color dangerHigh = Color(0xFFDA4C4C);

  // ── AgriBot accent color ─────────────────────────────────────────────────
  static const Color agriBotColor = Color(0xFF5E4AE3);

  // ── Light theme ──────────────────────────────────────────────────────────
  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  // ── Dark theme ───────────────────────────────────────────────────────────
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg = isDark ? darkBackgroundColor : backgroundColor;
    final card = isDark ? darkCardColor : cardColor;
    final text = isDark ? darkTextColor : textColor;
    final muted = isDark ? darkMutedTextColor : mutedTextColor;
    final stroke = isDark ? darkStrokeColor : strokeColor;
    final secondary = isDark ? darkSecondaryColor : secondaryColor;
    final baseTextTheme = GoogleFonts.manropeTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: isDark
          ? ColorScheme.dark(
              primary: primaryColor,
              secondary: accentColor,
              surface: card,
              error: dangerHigh,
            )
          : ColorScheme.light(
              primary: primaryColor,
              secondary: accentColor,
              surface: card,
              error: dangerHigh,
            ),
      scaffoldBackgroundColor: bg,
      cardColor: card,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        iconTheme: IconThemeData(color: text),
      ),
      textTheme: baseTextTheme.copyWith(
        titleLarge: GoogleFonts.fraunces(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: text,
        ),
        titleMedium: GoogleFonts.fraunces(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: text,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 16,
          color: text,
          height: 1.5,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 14,
          color: muted,
          height: 1.45,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: primaryColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 1.6),
        ),
        hintStyle: baseTextTheme.bodyMedium?.copyWith(
          color: muted.withValues(alpha: 0.7),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        indicatorColor: accentColor.withValues(alpha: 0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final baseStyle = baseTextTheme.labelSmall?.copyWith(
            fontSize: 10.5,
            height: 1.1,
            letterSpacing: -0.2,
          );
          if (states.contains(WidgetState.selected)) {
            return baseStyle?.copyWith(
              fontWeight: FontWeight.w700,
              color: primaryColor,
            );
          }
          return baseStyle?.copyWith(color: muted);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryColor);
          }
          return IconThemeData(color: muted.withValues(alpha: 0.7));
        }),
      ),
    );
  }
}

/// BuildContext extension for brightness-aware app colors / gradients.
extension AppThemeContext on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get appBgColor =>
      isDark ? AppTheme.darkBackgroundColor : AppTheme.backgroundColor;

  Color get appCardColor =>
      isDark ? AppTheme.darkCardColor : AppTheme.cardColor;

  Color get appTextColor =>
      isDark ? AppTheme.darkTextColor : AppTheme.textColor;

  Color get appMutedColor =>
      isDark ? AppTheme.darkMutedTextColor : AppTheme.mutedTextColor;

  Color get appStrokeColor =>
      isDark ? AppTheme.darkStrokeColor : AppTheme.strokeColor;

  Color get appSecondaryColor =>
      isDark ? AppTheme.darkSecondaryColor : AppTheme.secondaryColor;

  LinearGradient get appHeroGradient =>
      isDark ? AppTheme.darkHeroGradient : AppTheme.heroGradient;

  LinearGradient get appCardGradient =>
      isDark ? AppTheme.darkCardGradient : AppTheme.cardGradient;

  LinearGradient get appNavGradient =>
      isDark ? AppTheme.darkNavGradient : AppTheme.navGradient;
}
