import 'package:docsafe/config/color_file.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle docSafeSemiBoldText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: size.height(36),
    foreground: Paint()
      ..shader =
          const LinearGradient(colors: [AppColors.kEAAA8D, AppColors.k68D9A3])
              .createShader(const Rect.fromLTWH(0.0, 0.0, 400.0, 100.0)),
  );

  static TextStyle semiBoldLargeText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(36),
      color: AppColors.kFFFFFF);

  static TextStyle semiBoldRegularText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(18),
      // color: AppColors.k68D9A3
    color: Color(0xff6167DE)
  );

  static TextStyle normalSmallText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: size.height(12),
      color: AppColors.kF2F2F2);

  static TextStyle semiBoldMediumText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(12),
      color: AppColors.kF2F2F2,
      decoration: TextDecoration.underline);

  static TextStyle normalRegularText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: size.height(14),
      color: AppColors.k707070);

}
