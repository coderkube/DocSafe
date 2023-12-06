import 'package:docsafe/components/button_view.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

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
            vertical: size.height(18), horizontal: size.width(15)),
        child: GetBuilder(
          init: Get.find<AuthController>(),
          builder: (controller) {
            return Column(
              children: [
                Text(
                  "Create\nNew Password",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.semiBoldLargeText,
                ),
                Text(
                  "Your new password must be different\nfrom previous used passwords.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.normalRegularText
                      .copyWith(fontSize: size.height(16)),
                ),
                size.heightSpace(30),
                TextFormFieldCommon(
                  hintText: "Password",
                  controller: controller.passwordController,
                  suffixIcon: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.visiblePassword =
                            !controller.visiblePassword;
                        controller.update();
                      },
                      child: Icon(controller.visiblePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                  obscureText: controller.visiblePassword,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                ),
                size.heightSpace(15),
                TextFormFieldCommon(
                  hintText: "Confirm Password",
                  controller: controller.confirmPasswordController,
                  suffixIcon: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.confirmVisiblePassword =
                            !controller.confirmVisiblePassword;
                        controller.update();
                      },
                      child: Icon(controller.confirmVisiblePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                  obscureText: controller.confirmVisiblePassword,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                ),
                size.heightSpace(30),
                ButtonViewCommon(onTap: () {}, text: "Reset Password")
              ],
            );
          },
        ),
      ),
    );
  }
}
