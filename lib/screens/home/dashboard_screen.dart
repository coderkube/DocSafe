import 'package:carousel_slider/carousel_slider.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/dash_board_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<DashBoardController>(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.k23242E,
          appBar: AppBar(
            backgroundColor: AppColors.k23242E,
            title: RichText(
                text: TextSpan(
                    text: "hello,\t".tr,
                    style: AppTextStyle.semiBoldLargeText
                        .copyWith(fontSize: size.height(22)),
                    children: [
                      TextSpan(
                          text: "Admin !",
                          style: AppTextStyle.semiBoldLargeText
                              .copyWith(color: AppColors.k6167DE))
                    ])),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height(26), horizontal: size.width(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "card".tr,
                      style: AppTextStyle.semiBoldMediumRegularText,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height(4), horizontal: size.width(15)),
                      decoration: BoxDecoration(
                        color: AppColors.k68D9A3,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("view_all".tr,
                          style: AppTextStyle.semiBoldSmallText),
                    )
                  ],
                ),
                size.heightSpace(15),
                CreditCardWidget(
                  height: size.height(181),
                  width: size.width(284),
                  padding: size.height(8),
                  frontCardBorder: Border.all(
                      color: AppColors.kF2F2F2.withOpacity(0.20), width: 1),
                  backCardBorder: Border.all(
                      color: AppColors.kF2F2F2.withOpacity(0.20), width: 1),
                  cardNumber: "1234 1234 1234 1234",
                  expiryDate: "12/26",
                  cardHolderName: "DHARMIK AMBALIYA",
                  isHolderNameVisible: true,
                  cvvCode: "1234",
                  showBackView: true,
                  bankName: "SBI",
                  backgroundImage: AppImagePath.cardImg,
                  cardBgColor: AppColors.k001421,
                  cardType: CardType.mastercard,
                  chipColor: AppColors.kd99238,
                  enableFloatingCard: true,
                  obscureCardCvv: false,
                  obscureCardNumber: false,
                  onCreditCardWidgetChange: (value) {},
                ),
                // CarouselSlider(
                //   carouselController: CarouselController(),
                //     items: [
                //   ,
                // ], options: CarouselOptions()),
                size.heightSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {

                      },
                      child: Container(
                        padding: EdgeInsets.all(size.height(3)),
                        decoration: const BoxDecoration(
                            color: AppColors.k68D9A3, shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    size.widthSpace(20),
                    Container(
                      padding: EdgeInsets.all(size.height(3)),
                      decoration: BoxDecoration(
                          color: AppColors.k68D9A3,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1,
                              color: AppColors.kF2F2F2.withOpacity(0.25))),
                      child: const Icon(Icons.arrow_forward),
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     InkWell(
                //       highlightColor: Colors.transparent,
                //       splashFactory: NoSplash.splashFactory,
                //       onTap: () {
                //
                //       },
                //       child: Container(
                //         padding: EdgeInsets.all(size.height(10)),
                //         decoration: BoxDecoration(
                //             color: currentPage == 0
                //                 ? AppColor.whiteColor
                //                 : AppColor.k00A3ADColor,
                //             shape: BoxShape.circle,
                //             border: Border.all(
                //                 width: 1,
                //                 color: currentPage == 0
                //                     ? AppColor.k828A9DColor
                //                     : AppColor.k00A3ADColor)),
                //         child: SvgPicture.asset(
                //           ImagePath.leftArrowIcon,
                //           color: currentPage == 0
                //               ? AppColor.k828A9DColor
                //               : AppColor.whiteColor,
                //         ),
                //       ),
                //     ),
                //     size.widthSpace(22),
                //     InkWell(
                //       highlightColor: Colors.transparent,
                //       splashFactory: NoSplash.splashFactory,
                //       onTap: rightButtonOnTap,
                //       child: Container(
                //         padding: EdgeInsets.all(size.height(10)),
                //         decoration: BoxDecoration(
                //             color: currentPage == 2
                //                 ? AppColor.whiteColor
                //                 : AppColor.k00A3ADColor,
                //             shape: BoxShape.circle,
                //             border: Border.all(
                //                 width: 1,
                //                 color: currentPage == 2
                //                     ? AppColor.k828A9DColor
                //                     : AppColor.k00A3ADColor)),
                //         child: Transform.rotate(
                //           angle: 3.15,
                //           child: SvgPicture.asset(ImagePath.leftArrowIcon,
                //               color: currentPage == 2
                //                   ? AppColor.k828A9DColor
                //                   : AppColor.whiteColor),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                size.heightSpace(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "recently_used".tr,
                      style: AppTextStyle.semiBoldMediumRegularText,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height(4), horizontal: size.width(15)),
                      decoration: BoxDecoration(
                        color: AppColors.k68D9A3,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text("view_all".tr,
                          style: AppTextStyle.semiBoldSmallText),
                    )
                  ],
                ),
                size.heightSpace(20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, mainAxisSpacing: size.height(15)),
                    itemCount: 18,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SvgPicture.asset(AppImagePath.fileImg),
                          size.heightSpace(10),
                          Text("Loreds",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.lightRegularText)
                        ],
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await Supabase.instance.client.auth.signOut();
                      Get.offNamed("/SignIn");
                    },
                    child: const Text("Sign Out"))
              ],
            ),
          ),
        );
      },
    );
  }
}
