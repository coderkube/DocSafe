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
        body: SingleChildScrollView(
          child: GetBuilder(
              init: Get.find<AuthController>(),
              builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width(15), vertical: size.height(22)),
                  child: GetBuilder(
                    init: Get.find<AuthController>(),
                    builder: (controller) {
                      return Column(
                        children: [
                          size.heightSpace(35),
                          Text(
                            "Sign Up",
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
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldCommon(
                                  hintText: "First Name",
                                  controller: controller.firstNameController,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              size.widthSpace(15),
                              Expanded(
                                child: TextFormFieldCommon(
                                  hintText: "Last Name",
                                  controller: controller.lastNameController,
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                          size.heightSpace(15),
                          Form(
                            key: controller.signUpFormKey,
                              child: Column(
                            children: [
                              TextFormFieldCommon(
                                hintText: "Email",
                                controller: controller.emailController,
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
                              size.heightSpace(30),
                              ButtonViewCommon(
                                  onTap: () {
                                    if (controller.signUpFormKey.currentState!.validate()) {
                                      controller.signUpNewUser();
                                    }
                                  },
                                  text: "Create Account"),
                            ],
                          )),
                          size.heightSpace(254),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "by_continuing,_you_agree_to DSA's\t".tr,
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
                      );
                    },
                  ),
                );
              }),
        ));
  }
}
