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
                padding: EdgeInsets.symmetric(horizontal: size.width(15)),
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
                            recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed("/SignUp"),
                              text: "sign_up".tr,
                              style: AppTextStyle.semiBoldMediumText
                                  .copyWith(fontSize: size.height(14)))
                        ])),
                    size.heightSpace(30),
                    TextFormFieldCommon(
                      hintText: "Email",
                      controller: controller.signInEmailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    size.heightSpace(15),
                    TextFormFieldCommon(
                      hintText: "Password",
                      controller: controller.signInPasswordController,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        onTap: () => Get.toNamed("/ResetPassword"),
                        child: Text(
                          "Forgot Password?",
                          style: AppTextStyle.normalRegularText
                              .copyWith(color: AppColors.k6167DE),
                        ),
                      ),
                    ),
                    size.heightSpace(30),
                    ButtonViewCommon(onTap: () {
                      controller.signIn();
                    }, text: "sign_in".tr),
                    size.heightSpace(30),
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
                  ],
                ),
              );
            }),
      ),
    );
  }
}
