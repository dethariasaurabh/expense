import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_dimens.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
        backgroundColor: AppColors.whiteColor,
        primaryTextTheme: GoogleFonts.montserratTextTheme(),
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        shadowColor: AppColors.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          titleTextStyle: AppTextStyle.xLargeBoldText.copyWith(
            color: AppColors.secondaryTextColor,
          ),
          elevation: 0.0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: AppColors.secondaryTextColor,
          ),
        ),
      );

  static ThemeData get darkThemeData => ThemeData(
        backgroundColor: AppColors.darkColor,
        primaryTextTheme: GoogleFonts.montserratTextTheme(),
      );

  static List<BoxShadow> get commonShadow => [
        const BoxShadow(
          color: AppColors.primaryColorShade200,
          blurRadius: Dimens.radius10,
        ),
      ];

  static List<BoxShadow> get whiteShadow => [
        const BoxShadow(
          color: AppColors.whiteShade200,
          blurRadius: Dimens.radius10,
        ),
      ];
}
