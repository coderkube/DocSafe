import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.k121212,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset(AppImagePath.splashScreenLogo, color: AppColors.k6167DE,)),
          size.heightSpace(22),
          Text("docSafe".tr, style: AppTextStyle.semiBoldLargeText)
        ],
      ),
    );
  }
}
