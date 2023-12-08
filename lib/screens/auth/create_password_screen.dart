import 'package:docsafe/components/app_bar.dart';
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
      appBar: const AppBarCommon(),
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
                  labelText: "Password",
                  controller: controller.createPasswordController,
                  suffixIcon: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.createVisiblePassword =
                            !controller.createVisiblePassword;
                        controller.update();
                      },
                      child: Icon(controller.createVisiblePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                  obscureText: controller.createVisiblePassword,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                ),
                size.heightSpace(15),
                TextFormFieldCommon(
                  labelText: "Confirm Password",
                  controller: controller.confirmPasswordController,
                  suffixIcon: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.createConfirmVisiblePassword =
                            !controller.createConfirmVisiblePassword;
                        controller.update();
                      },
                      child: Icon(controller.createConfirmVisiblePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined)),
                  obscureText: controller.createConfirmVisiblePassword,
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
