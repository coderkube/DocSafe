import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<SettingController>(),
      builder: (controller) {
      return const Scaffold(
        backgroundColor: AppColors.k23242E,
        body: Placeholder(),
      );
    },);
  }
}
