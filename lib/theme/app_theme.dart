import 'package:expense/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
        backgroundColor: AppColors.whiteColor,
        primaryTextTheme: GoogleFonts.montserratTextTheme(),
      );

  static ThemeData get darkThemeData => ThemeData(
        backgroundColor: AppColors.darkColor,
        primaryTextTheme: GoogleFonts.montserratTextTheme(),
      );
}
