import 'package:docsafe/components/app_bar.dart';
import 'package:docsafe/components/button_view.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height(25), horizontal: size.width(15)),
                    child: Column(
                      children: [
                        size.heightSpace(35),
                        Text(
                          "sign_up".tr,
                          style: AppTextStyle.semiBoldLargeText
                              .copyWith(color: AppColors.kF2F2F2),
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Already have an account?\t".tr,
                                style: AppTextStyle.normalRegularText,
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.toNamed("/SignIn"),
                                  text: "sign_in".tr,
                                  style: AppTextStyle.semiBoldMediumText
                                      .copyWith(fontSize: size.height(14)))
                            ])),
                        size.heightSpace(30),
                        Form(
                            key: controller.signUpFormKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormFieldCommon(
                                        labelText: "first_name".tr,
                                        controller:
                                            controller.firstNameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'please_enter_first_name'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    size.widthSpace(15),
                                    Expanded(
                                      child: TextFormFieldCommon(
                                        labelText: "last_name".tr,
                                        controller: controller.lastNameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'please_enter_last_name'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                size.heightSpace(15),
                                TextFormFieldCommon(
                                  labelText: "email".tr,
                                  controller: controller.signUpEmailController,
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
                                size.heightSpace(15),
                                TextFormFieldCommon(
                                  labelText: "password".tr,
                                  controller: controller.signUpPasswordController,
                                  suffixIcon: InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        controller.signUpVisiblePassword =
                                            !controller.signUpVisiblePassword;
                                        controller.update();
                                      },
                                      child: Icon(controller.signUpVisiblePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined)),
                                  obscureText: controller.signUpVisiblePassword,
                                  obscuringCharacter: '*',
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "please_enter_password".tr;
                                    } else if (value.length < 6) {
                                      return "must_be_more_than_5_character".tr;
                                    }
                                    return null;
                                  },
                                ),
                                size.heightSpace(15),
                                TextFormFieldCommon(
                                  labelText: "confirm_password".tr,
                                  controller:
                                      controller.signUpConfirmPasswordController,
                                  suffixIcon: InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        controller.signUpConfirmVisiblePassword =
                                            !controller
                                                .signUpConfirmVisiblePassword;
                                        controller.update();
                                      },
                                      child: Icon(
                                          controller.signUpConfirmVisiblePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined)),
                                  obscureText:
                                      controller.signUpConfirmVisiblePassword,
                                  obscuringCharacter: '*',
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "please_enter_password".tr;
                                    } else if (value !=
                                        controller
                                            .signUpPasswordController.text) {
                                      return "not_match".tr;
                                    }
                                    return null;
                                  },
                                ),
                                size.heightSpace(30),
                                ButtonViewCommon(
                                    onTap: () {
                                      if (controller.signUpFormKey.currentState!
                                          .validate()) {
                                        controller.signUpNewUser();
                                      }
                                    },
                                    text: "create_account".tr),
                              ],
                            )),
                        size.heightSpace(230),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "by_continuing,_you_agree_to_DSA's\t".tr,
                              style: AppTextStyle.normalSmallText,
                              children: [
                                TextSpan(
                                    text: "terms_&_conditions_&\n".tr,
                                    style: AppTextStyle.semiBoldMediumText),
                                TextSpan(
                                    text: "privacy_policy".tr,
                                    style: AppTextStyle.semiBoldMediumText),
                              ]),
                        )
                      ],
                    ),
                  ),
                )),
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
