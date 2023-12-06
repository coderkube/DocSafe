import 'package:docsafe/components/button_view.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.k23242E,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppColors.k23242E,
        iconTheme: const IconThemeData(color: AppColors.kF2F2F2),
        title: Text(
          "back".tr,
          style: AppTextStyle.semiBoldRegularText
              .copyWith(color: AppColors.kF2F2F2),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width(15), vertical: size.height(30)),
        child: GetBuilder(
          init: Get.find<AuthController>(),
          builder: (controller) {
            return Column(
              children: [
                Text(
                  "Reset Password",
                  style: AppTextStyle.semiBoldLargeText
                      .copyWith(color: AppColors.kF2F2F2),
                ),
                Text(
                    "Enter the email associated with your account\nand we'll send an email with instructions\nto reset your password.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normalRegularText),
                size.heightSpace(30),
                TextFormFieldCommon(
                  hintText: "Email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                size.heightSpace(30),
                ButtonViewCommon(onTap: () {
                  Get.toNamed("/CheckMail");
                }, text: "Send Email"),
              ],
            );
          },
        ),
      ),
    );
  }
}
