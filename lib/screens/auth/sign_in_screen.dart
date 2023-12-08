import 'package:docsafe/components/app_bar.dart';
import 'package:docsafe/components/button_view.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  body: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width(15)),
                          child: Column(
                            children: [
                              size.heightSpace(64),
                              Text(
                                "welcome_back!".tr,
                                style: AppTextStyle.semiBoldLargeText
                                    .copyWith(color: AppColors.kF2F2F2),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "i’m_a_new_user!\t".tr,
                                      style: AppTextStyle.normalRegularText,
                                      children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap =
                                              () => Get.toNamed("/SignUp"),
                                        text: "sign_up".tr,
                                        style: AppTextStyle.semiBoldMediumText
                                            .copyWith(
                                                fontSize: size.height(14)))
                                  ])),
                              size.heightSpace(30),
                              Form(
                                  key: controller.signInFormKey,
                                  child: Column(
                                    children: [
                                      TextFormFieldCommon(
                                        labelText: "email".tr,
                                        controller:
                                            controller.signInEmailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'please_enter_email'.tr;
                                          } else if (!RegExp(controller
                                                  .emailValidationRegExp)
                                              .hasMatch(value)) {
                                            return 'please_enter_valid_email'
                                                .tr;
                                          }
                                          return null;
                                        },
                                      ),
                                      size.heightSpace(15),
                                      TextFormFieldCommon(
                                        labelText: "password".tr,
                                        controller:
                                            controller.signInPasswordController,
                                        suffixIcon: InkWell(
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              controller.signInVisiblePassword =
                                                  !controller
                                                      .signInVisiblePassword;
                                              controller.update();
                                            },
                                            child: Icon(controller
                                                    .signInVisiblePassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined)),
                                        obscureText:
                                            controller.signInVisiblePassword,
                                        obscuringCharacter: '*',
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "please_enter_password".tr;
                                          } else if (value.length < 6) {
                                            return "must_be_more_than_5_character"
                                                .tr;
                                          }
                                          return null;
                                        },
                                      ),
                                      size.heightSpace(15),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          splashFactory: NoSplash.splashFactory,
                                          highlightColor: Colors.transparent,
                                          onTap: () =>
                                              Get.toNamed("/ResetPassword"),
                                          child: Text(
                                            "forgot_password?".tr,
                                            style: AppTextStyle
                                                .normalRegularText
                                                .copyWith(
                                                    color: AppColors.k6167DE),
                                          ),
                                        ),
                                      ),
                                      size.heightSpace(30),
                                      ButtonViewCommon(
                                          onTap: () {
                                            if (controller
                                                .signInFormKey.currentState!
                                                .validate()) {
                                              controller.signIn();
                                            }
                                          },
                                          text: "sign_in".tr),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: Container()),
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
                            ),
                            size.heightSpace(20)
                          ],
                        ),
                      )
                    ],
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
        });
  }
}
// size.heightSpace(30),
// Row(
//   children: [
//     Expanded(
//       child: Container(
//         color: AppColors.k757575,
//         child: const Divider(
//           height: 1,
//         ),
//       ),
//     ),
//     size.widthSpace(10),
//     Text("OR", style: AppTextStyle.mediumRegularText),
//     size.widthSpace(10),
//     Expanded(
//       child: Container(
//         color: AppColors.k757575,
//         child: const Divider(
//           height: 1,
//         ),
//       ),
//     ),
//   ],
// ),
// size.heightSpace(30),
