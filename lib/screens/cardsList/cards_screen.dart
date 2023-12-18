import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/screens/home/card/add_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:docsafe/components/pop_up_menu.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
        init: Get.find<CardController>(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.k23242E,
            elevation: 0,
            title: Text('my_cards'.tr,
                style: AppTextStyle.semiBoldMediumRegularText),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=> const AddCardScreen());
                  },
                  child: SvgPicture.asset(
                    AppImagePath.newFolderImg,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.k23242E,
          body: SingleChildScrollView(
            controller: controller.scrollController,
            child: (controller.cardList != null && controller.cardList!.isNotEmpty)
                ? Container(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return size.heightSpace(5);
                },
                shrinkWrap: true,
                controller: controller.scrollController,
                itemCount: controller.cardList!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      CreditCardWidget(
                        cardNumber: controller.cardList?[index].cardNumber ?? "",
                        expiryDate: controller.cardList?[index].expiryDate ?? "",
                        cardHolderName: controller.cardList?[index].cardHolderName ?? "",
                        cvvCode: controller.cardList?[index].securityCode ?? "",
                        showBackView: false,
                        isChipVisible: false,padding: 10,isHolderNameVisible: true,
                        cardBgColor: AppColors.kB370DD,
                        onCreditCardWidgetChange: (CreditCardBrand brand) {

                        }, // Callback for anytime credit card brand is changed
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: ()async{
                                controller.cardList?.removeAt(index);
                                await localStorage.write('cardList',
                                    controller.cardList?.map((folderInfo) => folderInfo.toJson()).toList());
                                controller.update();
                              },
                              child: const Icon(Icons.close,color: Colors.white,))
                        ],
                      ).paddingOnly(top: 20,right: 20)
                    ],
                  );
                },
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: SvgPicture.asset(
                        'assets/images/ic_empty_screen.svg')),
                size.heightSpace(40),
                InkWell(
                  onTap: () {
                    Get.to(()=> const AddCardScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 73),
                    decoration: BoxDecoration(
                        color: AppColors.k6167DE,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      'add_card'.tr,
                      style: AppTextStyle.semiBoldMediumRegularText
                          .copyWith(color: AppColors.kFFFFFF),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
