import 'package:expense/theme/app_colors.dart';
import 'package:expense/theme/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // Small style
  static TextStyle get smallText => GoogleFonts.montserrat(
        color: AppColors.darkTitleColor,
        fontSize: Dimens.fontSize12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get smallBoldText => smallText.copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle get smallBlackText => smallText.copyWith(
        fontWeight: FontWeight.w800,
      );

  // medium style
  static TextStyle get mediumText => GoogleFonts.montserrat(
        color: AppColors.darkTitleColor,
        fontSize: Dimens.fontSize14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get mediumBlackText => mediumText.copyWith(
        fontWeight: FontWeight.w800,
      );

  static TextStyle get mediumBoldText => mediumText.copyWith(
        fontWeight: FontWeight.w600,
      );

  // xxLarge style
  static TextStyle get xxLargeText => GoogleFonts.montserrat(
        color: AppColors.darkTitleColor,
        fontSize: Dimens.fontSize24,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get xxLargeBlackText => xxLargeText.copyWith(
        fontWeight: FontWeight.w800,
      );

  static TextStyle get xxLargeBoldText => xxLargeText.copyWith(
        fontWeight: FontWeight.w600,
      );

  // xLarge style
  static TextStyle get xLargeText => GoogleFonts.montserrat(
        color: AppColors.darkTitleColor,
        fontSize: Dimens.fontSize18,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get xLargeBlackText => xLargeText.copyWith(
        fontWeight: FontWeight.w800,
      );

  static TextStyle get xLargeBoldText => xLargeText.copyWith(
        fontWeight: FontWeight.w600,
      );

  static TextStyle textStyle({
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return mediumText.copyWith(
      color: fontColor ?? AppColors.darkTitleColor,
      fontSize: fontSize ?? Dimens.fontSize14,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
