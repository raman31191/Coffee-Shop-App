import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primaryColor = Color(0xFFC67C4E);
  static const lightBackground = Color(0xFFF9F2ED);
  static const lightBeige = Color(0xFFEDD6C8);
  static const textDark = Color(0xFF313131);
  static const borderColor = Color(0xFFE3E3E3);
  static const darkBackground = Color(0xFF1E1E1E);
  static const darkCard = Color(0xFF2C2C2C);
}

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackground,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    surface: AppColors.lightBackground,
    secondary: AppColors.lightBeige,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightBackground,
    iconTheme: IconThemeData(color: AppColors.textDark),
    elevation: 0,
  ),
  textTheme: GoogleFonts.soraTextTheme().copyWith(
    bodyLarge: GoogleFonts.sora(color: AppColors.textDark),
  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryColor,
    surface: AppColors.darkBackground,
    secondary: AppColors.lightBeige,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
  ),
  textTheme: GoogleFonts.soraTextTheme().copyWith(
    bodyLarge: GoogleFonts.sora(color: Colors.white),
  ),
);
