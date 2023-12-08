import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.k23242E,
      body: GetBuilder(
        init: Get.find<OnBoardingController>(),
        builder: (controller) {
          return Column(
            children: [
              size.heightSpace(50),
              Column(
                children: [
                  SizedBox(
                    height: size.height(550),
                    width: double.infinity,
                    child: PageView(
                      controller: controller.pageController,
                      onPageChanged: (value) {
                        controller.currentIndex = value;
                        controller.update();
                      },
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              AppImagePath.onBoardImg1,
                              height: size.height(368),
                              width: size.width(368),
                            ),
                            size.heightSpace(40),
                            Text(
                              "boost_productivity".tr,
                              style: AppTextStyle.semiBoldLargeText
                                  .copyWith(fontSize: size.height(28)),
                            ),
                            size.heightSpace(10),
                            Text(
                                "foc.io_helps_you_boost_your_productivity\non_a_different_level"
                                    .tr,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.normalRegularText
                                    .copyWith(color: AppColors.kFFFFFF))
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              AppImagePath.onBoardImg2,
                              height: size.height(368),
                              width: size.width(368),
                            ),
                            size.heightSpace(40),
                            Text(
                              "work_seamlessly".tr,
                              style: AppTextStyle.semiBoldLargeText
                                  .copyWith(fontSize: size.height(28)),
                            ),
                            size.heightSpace(10),
                            Text(
                                "get_your_work_done_seamlessly\nwithout_interruption"
                                    .tr,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.normalRegularText
                                    .copyWith(color: AppColors.kFFFFFF))
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              AppImagePath.onBoardImg3,
                              height: size.height(368),
                              width: size.width(368),
                            ),
                            size.heightSpace(40),
                            Text(
                              "achieve_higher_goals".tr,
                              style: AppTextStyle.semiBoldLargeText
                                  .copyWith(fontSize: size.height(28)),
                            ),
                            size.heightSpace(10),
                            Text(
                              "by_boosting_your_productivity_we_help\nyou_achieve_higher_goals"
                                  .tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.normalRegularText
                                  .copyWith(color: AppColors.kFFFFFF),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  size.heightSpace(40),
                  GestureDetector(
                    onTap: () => Get.offNamed("/Welcome"),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height(15)),
                      width: size.width(220),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.k6167DE),
                      child: Text(
                        "get_started".tr,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.boldRegularText,
                      ),
                    ),
                  ),
                ],
              ),
              size.heightSpace(40),
              Center(
                child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: size.height(8),
                    dotWidth: size.width(8),
                    activeDotColor: AppColors.kFFFFFF,
                    // type: WormType.thinUnderground,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
