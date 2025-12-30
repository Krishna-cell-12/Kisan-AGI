import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSpacing {
  // Spacing values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Edge insets shortcuts
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  // Horizontal padding
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
}

/// Border radius constants for consistent rounded corners
class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
}

// =============================================================================
// TEXT STYLE EXTENSIONS
// =============================================================================

/// Extension to add text style utilities to BuildContext
/// Access via context.textStyles
extension TextStyleContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}

/// Helper methods for common text style modifications
extension TextStyleExtensions on TextStyle {
  /// Make text bold
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// Make text semi-bold
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Make text medium weight
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Make text normal weight
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);

  /// Make text light
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Add custom color
  TextStyle withColor(Color color) => copyWith(color: color);

  /// Add custom size
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

// =============================================================================
// COLORS
// =============================================================================

/// Agricultural color palette for Kisan-AGI
class LightModeColors {
  // Primary: Deep Emerald Green - represents agriculture and growth
  static const lightPrimary = Color(0xFF2E7D32);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFC8E6C9);
  static const lightOnPrimaryContainer = Color(0xFF1B5E20);

  // Secondary: Harvest Gold - represents prosperity
  static const lightSecondary = Color(0xFFFFB300);
  static const lightOnSecondary = Color(0xFF000000);
  static const lightSecondaryContainer = Color(0xFFFFE082);
  static const lightOnSecondaryContainer = Color(0xFF6D4C00);

  // Tertiary: Earth Brown for grounding
  static const lightTertiary = Color(0xFF6D4C41);
  static const lightOnTertiary = Color(0xFFFFFFFF);

  // Error colors
  static const lightError = Color(0xFFD32F2F);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFFFCDD2);
  static const lightOnErrorContainer = Color(0xFFB71C1C);

  // Surface and background: Clean white/off-white
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightOnSurface = Color(0xFF212121);
  static const lightBackground = Color(0xFFFAFAFA);
  static const lightSurfaceVariant = Color(0xFFF5F5F5);
  static const lightOnSurfaceVariant = Color(0xFF424242);

  // Accent colors for recovery steps
  static const accentRed = Color(0xFFE53935);
  static const accentBlue = Color(0xFF1E88E5);
  static const accentGreen = Color(0xFF43A047);

  static const lightOutline = Color(0xFFBDBDBD);
  static const lightShadow = Color(0xFF000000);
  static const lightInversePrimary = Color(0xFF81C784);
}

/// Dark mode colors for Kisan-AGI
class DarkModeColors {
  // Primary: Lighter green for visibility on dark background
  static const darkPrimary = Color(0xFF81C784);
  static const darkOnPrimary = Color(0xFF1B5E20);
  static const darkPrimaryContainer = Color(0xFF2E7D32);
  static const darkOnPrimaryContainer = Color(0xFFC8E6C9);

  // Secondary: Bright gold for dark mode
  static const darkSecondary = Color(0xFFFFD54F);
  static const darkOnSecondary = Color(0xFF6D4C00);
  static const darkSecondaryContainer = Color(0xFFFFB300);
  static const darkOnSecondaryContainer = Color(0xFFFFE082);

  // Tertiary
  static const darkTertiary = Color(0xFFBCAAA4);
  static const darkOnTertiary = Color(0xFF3E2723);

  // Error colors
  static const darkError = Color(0xFFEF5350);
  static const darkOnError = Color(0xFFB71C1C);
  static const darkErrorContainer = Color(0xFFC62828);
  static const darkOnErrorContainer = Color(0xFFFFCDD2);

  // Surface and background
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkOnSurface = Color(0xFFE0E0E0);
  static const darkSurfaceVariant = Color(0xFF2C2C2C);
  static const darkOnSurfaceVariant = Color(0xFFBDBDBD);

  // Accent colors for recovery steps
  static const accentRed = Color(0xFFEF5350);
  static const accentBlue = Color(0xFF42A5F5);
  static const accentGreen = Color(0xFF66BB6A);

  static const darkOutline = Color(0xFF757575);
  static const darkShadow = Color(0xFF000000);
  static const darkInversePrimary = Color(0xFF2E7D32);
}

/// Font size constants
class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}

// =============================================================================
// THEMES
// =============================================================================

/// Light theme with modern, neutral aesthetic
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
    surfaceContainerHighest: LightModeColors.lightSurfaceVariant,
    onSurfaceVariant: LightModeColors.lightOnSurfaceVariant,
    outline: LightModeColors.lightOutline,
    shadow: LightModeColors.lightShadow,
    inversePrimary: LightModeColors.lightInversePrimary,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightModeColors.lightBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: LightModeColors.lightOnSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shadowColor: LightModeColors.lightShadow.withValues(alpha: 0.1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: LightModeColors.lightSurface,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: LightModeColors.lightOnPrimary,
      backgroundColor: LightModeColors.lightPrimary,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: LightModeColors.lightSecondary,
    foregroundColor: LightModeColors.lightOnSecondary,
    elevation: 4,
  ),
  textTheme: _buildTextTheme(Brightness.light),
);

/// Dark theme with good contrast and readability
ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: DarkModeColors.darkPrimary,
    onPrimary: DarkModeColors.darkOnPrimary,
    primaryContainer: DarkModeColors.darkPrimaryContainer,
    onPrimaryContainer: DarkModeColors.darkOnPrimaryContainer,
    secondary: DarkModeColors.darkSecondary,
    onSecondary: DarkModeColors.darkOnSecondary,
    tertiary: DarkModeColors.darkTertiary,
    onTertiary: DarkModeColors.darkOnTertiary,
    error: DarkModeColors.darkError,
    onError: DarkModeColors.darkOnError,
    errorContainer: DarkModeColors.darkErrorContainer,
    onErrorContainer: DarkModeColors.darkOnErrorContainer,
    surface: DarkModeColors.darkSurface,
    onSurface: DarkModeColors.darkOnSurface,
    surfaceContainerHighest: DarkModeColors.darkSurfaceVariant,
    onSurfaceVariant: DarkModeColors.darkOnSurfaceVariant,
    outline: DarkModeColors.darkOutline,
    shadow: DarkModeColors.darkShadow,
    inversePrimary: DarkModeColors.darkInversePrimary,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkModeColors.darkSurface,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: DarkModeColors.darkOnSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shadowColor: DarkModeColors.darkShadow.withValues(alpha: 0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: DarkModeColors.darkSurfaceVariant,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: DarkModeColors.darkOnPrimary,
      backgroundColor: DarkModeColors.darkPrimary,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DarkModeColors.darkSecondary,
    foregroundColor: DarkModeColors.darkOnSecondary,
    elevation: 4,
  ),
  textTheme: _buildTextTheme(Brightness.dark),
);

/// Build text theme using Nunito font family for warmth and accessibility
TextTheme _buildTextTheme(Brightness brightness) {
  return TextTheme(
    displayLarge: GoogleFonts.nunito(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: GoogleFonts.nunito(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.nunito(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.nunito(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: GoogleFonts.nunito(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.nunito(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: GoogleFonts.nunito(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),
    labelMedium: GoogleFonts.nunito(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
    labelSmall: GoogleFonts.nunito(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
  );
}
