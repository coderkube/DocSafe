import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<SplashController>(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.k23242E,
          body: GetBuilder(
            init: Get.find<SplashController>(),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset("assets/images/logo.png",height: size.height(124),width: size.width(144),)),
                  size.heightSpace(22),
                  Text("docSafe".tr, style: AppTextStyle.semiBoldLargeText)
                ],
              );
            },
          ),
        );
      },
    );
  }
}
