import 'package:docsafe/config/color_file.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle semiBoldLargeText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(36),
      color: AppColors.kFFFFFF);

  static TextStyle semiBoldRegularText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(18),
      color: AppColors.k6167DE
  );

  static TextStyle normalSmallText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: size.height(12),
      color: AppColors.kF2F2F2);

  static TextStyle semiBoldMediumText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(12),
      color: AppColors.k68D9A3,
      decoration: TextDecoration.underline);

  static TextStyle normalRegularText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: size.height(14),
      color: AppColors.kFFFFFF);

  static TextStyle mediumRegularText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: size.height(14),
      color: AppColors.k757575);

  static TextStyle boldRegularText = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: size.height(16),
      color: AppColors.kFFFFFF);

  static TextStyle semiBoldMediumLargeText = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: size.height(20),
  color: AppColors.k68D9A3);

  static TextStyle semiBoldMediumRegularText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(16),
      color: AppColors.kF2F2F2);

  static TextStyle semiBoldSmallText = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.height(12),
      color: AppColors.k23242E);

  static TextStyle lightRegularText = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: size.height(14),
      color: AppColors.kFFFFFF);
}
