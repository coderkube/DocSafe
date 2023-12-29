import 'package:docsafe/awsome_card/credit_card.dart';
import 'package:docsafe/awsome_card/style/card_background.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:docsafe/controllers/dash_board_controller.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

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
                          text: "there".tr,
                          style: AppTextStyle.semiBoldLargeText
                              .copyWith(color: AppColors.k6167DE))
                    ])),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: size.height(26),
              left: size.width(15),
              right: size.width(15),
            ),
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
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        Get.toNamed("/Card");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height(4), horizontal: size.width(15)),
                        decoration: BoxDecoration(
                          color: AppColors.k68D9A3,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text("view_all".tr,
                            style: AppTextStyle.semiBoldSmallText),
                      ),
                    )
                  ],
                ),
                size.heightSpace(15),
                Expanded(
                  child: Get.find<CardController>().pinCardList.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: Get.find<CardController>().pinCardList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.isCardFlip = !controller.isCardFlip;
                              controller.update();
                            },
                            child: CreditCard(
                              height: size.height(200),
                                width: size.width(300),
                                cardNumber: "${Get.find<CardController>().pinCardList[index].cardNumber}",
                                cardExpiry: "${Get.find<CardController>().pinCardList[index].expiryDate}",
                                cardHolderName: "${Get.find<CardController>().pinCardList[index].cardHolderName}",
                                cvv: "${Get.find<CardController>().pinCardList[index].securityCode}",
                                showBackSide: controller.isCardFlip,
                                frontBackground: CardBackgrounds.custom(0XFF001421),
                                backBackground: CardBackgrounds.custom(0XFF001421),
                                backTextColor: AppColors.kFFFFFF,
                            ),
                          ),
                        ],
                      );
                    },) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("you_do_not_have_a_PIN_card_yet.".tr, style: AppTextStyle.normalRegularText),
                      size.heightSpace(40),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          Get.toNamed("/Card");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 73),
                          decoration: BoxDecoration(
                              color: AppColors.k6167DE,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            'pin_card'.tr,
                            style: AppTextStyle.semiBoldMediumRegularText
                                .copyWith(color: AppColors.kFFFFFF),
                          ),
                        ),
                      )
                    ],
                  )
                ),
                size.heightSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "recently_used".tr,
                      style: AppTextStyle.semiBoldMediumRegularText,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () => Get.toNamed("/MySpace"),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height(4), horizontal: size.width(15)),
                        decoration: BoxDecoration(
                          color: AppColors.k68D9A3,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text("view_all".tr,
                            style: AppTextStyle.semiBoldSmallText),
                      ),
                    )
                  ],
                ),
                size.heightSpace(20),
                Expanded(
                  child: Get.find<MySpaceController>().pinFolderList.isNotEmpty ?
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, mainAxisSpacing: size.height(15)),
                    itemCount: Get.find<MySpaceController>().pinFolderList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              onTap: () async {
                                if(Get.find<MySpaceController>().pinFolderList[index].type == 'folder'){
                                  Get.find<MySpaceController>().selectedPinFolderIndex = index;
                                  Get.find<MySpaceController>().isPinList = true;
                                  Get.find<MySpaceController>().update();
                                  Get.toNamed("/SpaceItem");
                                } else {
                                  kDebugPrint("Open File--->---");
                                  await OpenFile.open("${Get.find<MySpaceController>().pinFolderList[index].path}");
                                }
                              },
                              child: Get.find<MySpaceController>().pinFolderList[index].type == "folder" ?
                              SvgPicture.asset(AppImagePath.fileImg) :
                              SvgPicture.asset(AppImagePath.pdfImg, height: size.height(55))),
                          size.heightSpace(10),
                          Text("${Get.find<MySpaceController>().pinFolderList[index].name}",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.lightRegularText)
                        ],
                      );
                    },
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("you_don't_have_any_pinned_documents".tr, style: AppTextStyle.normalRegularText),
                      size.heightSpace(40),
                      InkWell(
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed("/MySpace");
                        },
                        splashFactory: NoSplash.splashFactory,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 73),
                          decoration: BoxDecoration(
                              color: AppColors.k6167DE,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            'add_pin_document'.tr,
                            style: AppTextStyle.semiBoldMediumRegularText
                                .copyWith(color: AppColors.kFFFFFF),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
