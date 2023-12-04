import 'package:docsafe/components/button_view.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.k121212,
      backgroundColor: const Color(0xff23242E),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width(15), vertical: size.height(29)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            size.heightSpace(38),
            SvgPicture.asset(
              AppImagePath.splashScreenLogo,
              height: size.height(84),
              width: size.width(84),
            ),
            size.heightSpace(30),
            Text(
              "welcome".tr,
              style: AppTextStyle.semiBoldLargeText,
            ),
            size.heightSpace(30),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: size.height(17)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xff6167DE))),
              child: Text(
                "create_account".tr,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldRegularText,
              ),
            ),
            size.heightSpace(15),
            ButtonViewCommon(
                onTap: () {
                  Get.to(() => const SignInScreen());
                },
                text: "sign_in".tr),
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "by_continuing,_you_agree_to\t".tr,
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
    );
  }
}
