import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.k121212,
      backgroundColor: Color(0xff23242E),
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.k121212,
        iconTheme: const IconThemeData(color: AppColors.kF2F2F2),
        title: Text(
          "back".tr,
          style: AppTextStyle.semiBoldRegularText
              .copyWith(color: AppColors.kF2F2F2),
        ),
      ),
      body: Padding(
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
                      text: "sign_up".tr,
                      style: AppTextStyle.semiBoldMediumText
                          .copyWith(fontSize: size.height(14)))
                ])),
            size.heightSpace(30),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
