import 'package:docsafe/components/app_bar.dart';
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
    return GetBuilder(
      init: Get.find<AuthController>(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.k23242E,
              appBar: const AppBarCommon(),
              body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width(15), vertical: size.height(30)),
                  child: Column(
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
                      Form(
                          key: controller.resetPasswordFormKey,
                          child: Column(
                            children: [
                              TextFormFieldCommon(
                                labelText: "Email",
                                controller: controller.resetPasswordController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'please_enter_email'.tr;
                                  } else if (!RegExp(
                                          controller.emailValidationRegExp)
                                      .hasMatch(value)) {
                                    return 'please_enter_valid_email'.tr;
                                  }
                                  return null;
                                },
                              ),
                              size.heightSpace(30),
                              ButtonViewCommon(
                                  onTap: () {
                                    if (controller
                                        .resetPasswordFormKey.currentState!
                                        .validate()) {
                                      controller.resetPasswordForEmail();
                                    }
                                  },
                                  text: "Send Email"),
                            ],
                          ))
                    ],
                  )),
            ),
            controller.isLoading
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: AppColors.kBlack38,
                    child: Center(
                        child: CircularProgressIndicator(
                      strokeWidth: size.width(7),
                      strokeAlign: size.height(2),
                      color: AppColors.kFFFFFF,
                    )),
                  )
                : const SizedBox()
          ],
        );
      },
    );
  }
}
