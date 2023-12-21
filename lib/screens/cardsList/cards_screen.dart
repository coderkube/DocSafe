import 'package:docsafe/components/pop_up_menu.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:docsafe/controllers/dash_board_controller.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/screens/home/card/add_card_screen.dart';
import 'package:flutter/material.dart';
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
            iconTheme: const IconThemeData(
              color: AppColors.kFFFFFF
            ),
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
            child: controller.pinCardList.isNotEmpty || controller.cardList.isNotEmpty
                ? Container(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return size.heightSpace(5);
                    },
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemCount: controller.pinCardList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CreditCardWidget(
                            cardNumber: controller.pinCardList[index].cardNumber ?? "",
                            expiryDate: controller.pinCardList[index].expiryDate ?? "",
                            cardHolderName: controller.pinCardList[index].cardHolderName ?? "",
                            cvvCode: controller.pinCardList[index].securityCode ?? "",
                            showBackView: false,
                            isChipVisible: false,padding: 10,isHolderNameVisible: true,
                            cardBgColor: AppColors.kB370DD,
                            onCreditCardWidgetChange: (CreditCardBrand brand) {}, // Callback for anytime credit card brand is changed
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.push_pin,
                                  size: size.height(17),
                                  color: AppColors.k68D9A3),
                              PopUpButtonCommon(
                                pinText: 'unpin'.tr,
                                onSelected: (value) {
                                  Get.find<MySpaceController>().popUpMenuInitialValue = value;
                                  controller.update();
                                },
                                pinOnTap: () async {
                                  controller.cardList.add(controller.pinCardList[index]);
                                  await localStorage.write('cardList', controller.cardList.map((e) => e.toJson()).toList());
                                  controller.pinCardList.removeAt(index);
                                  await localStorage.write('pinCardList', controller.pinCardList.map((e) => e.toJson()).toList());
                                  controller.update();
                                },
                                deleteOnTap: () async {
                                  controller.pinCardList.removeAt(index);
                                  await localStorage.write('pinCardList',
                                      controller.pinCardList.map((folderInfo) => folderInfo.toJson()).toList());
                                  controller.update();
                                },
                                editOnTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.k3D3D3D,
                                        icon: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () => Get.back(),
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                                color: AppColors.kFFFFFF,
                                              )),
                                        ),
                                        iconPadding: EdgeInsets.zero,
                                        actions: [
                                          Form(
                                              key: controller.formKey,
                                              child: Column(
                                                children: [
                                                  TextFormFieldCommon(
                                                    controller: controller.cardHolderNameController,
                                                    hintText: 'card_holder_name'.tr,
                                                    onChanged: (p0) {
                                                      controller.update();
                                                    },
                                                  ),
                                                  size.heightSpace(20),
                                                  TextFormFieldCommon(
                                                    controller: controller.cardNumberController,
                                                    hintText: 'card_number'.tr,
                                                    keyboardType: TextInputType.number,
                                                    maxLength: 16,
                                                    onChanged: (p0) {
                                                      controller.update();
                                                    },
                                                  ),
                                                  size.heightSpace(10),
                                                  Row(
                                                    children: [
                                                      Expanded(child: TextFormFieldCommon(controller: controller.expiryDateController,
                                                        hintText: 'expiry_date'.tr,
                                                        maxLength: 5,
                                                        keyboardType: TextInputType.number,
                                                        onChanged: (input) {
                                                          if (input.length == 2 && !input.contains('/')) {
                                                            controller.expiryDateController.text = "$input/";
                                                            controller.expiryDateController.selection = TextSelection.fromPosition(
                                                              TextPosition(offset: controller.expiryDateController.text.length),
                                                            );
                                                          } else if (input.length == 2 && input.endsWith('/')) {
                                                            controller.expiryDateController.text = input.substring(0, 1);
                                                            controller.expiryDateController.selection = TextSelection.fromPosition(
                                                              TextPosition(offset: controller.expiryDateController.text.length),
                                                            );
                                                          }
                                                        },
                                                      )),
                                                      size.widthSpace(10),
                                                      Expanded(child: TextFormFieldCommon(controller: controller.securityCodeController,
                                                        hintText: 'security_code'.tr,
                                                        keyboardType: TextInputType.number,
                                                        maxLength: 3,
                                                        onChanged: (p0) {
                                                          controller.update();
                                                        },
                                                      )),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () async {

                                                      String holderName = controller.cardHolderNameController.text;
                                                      String cardNumber = controller.cardNumberController.text;
                                                      String expiryDate = controller.expiryDateController.text;
                                                      String securityCode = controller.securityCodeController.text;

                                                      if(holderName.isNotEmpty && cardNumber.isNotEmpty && expiryDate.isNotEmpty && securityCode.isNotEmpty){

                                                        controller.pinCardList[index].cardHolderName = holderName;
                                                        controller.pinCardList[index].cardNumber = cardNumber;
                                                        controller.pinCardList[index].expiryDate = expiryDate;
                                                        controller.pinCardList[index].securityCode = securityCode;

                                                        await localStorage.write('pinCardList', controller.pinCardList.map((e) => e.toJson()).toList());
                                                        controller.update();
                                                        Get.find<DashBoardController>().update();
                                                      }
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: size.height(10),
                                                            horizontal: size.width(35)),
                                                        decoration: BoxDecoration(
                                                            color: AppColors.k68D9A3,
                                                            borderRadius: BorderRadius.circular(5)),
                                                        child: Text("Save",
                                                            style: AppTextStyle.semiBoldSmallText.copyWith(color: AppColors.k242424))),
                                                  )
                                                ],
                                              )),
                                        ],
                                      );
                                    },);
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return size.heightSpace(5);
                    },
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemCount: controller.cardList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CreditCardWidget(
                            cardNumber: controller.cardList[index].cardNumber ?? "",
                            expiryDate: controller.cardList[index].expiryDate ?? "",
                            cardHolderName: controller.cardList[index].cardHolderName ?? "",
                            cvvCode: controller.cardList[index].securityCode ?? "",
                            showBackView: false,
                            isChipVisible: false,padding: 10,isHolderNameVisible: true,
                            cardBgColor: AppColors.kB370DD,
                            onCreditCardWidgetChange: (CreditCardBrand brand) {}, // Callback for anytime credit card brand is changed
                          ),
                          PopUpButtonCommon(
                            onSelected: (value) {
                              Get.find<MySpaceController>().popUpMenuInitialValue = value;
                              controller.update();
                            },
                            pinOnTap: () async {
                                controller.pinCardList.add(controller.cardList[index]);
                              await localStorage.write(
                                  'pinCardList', controller.pinCardList.map((e) => e.toJson()).toList());
                              controller.cardList.removeAt(index);
                              await localStorage.write('cardList', controller.cardList.map((e) => e.toJson()).toList());
                              controller.update();
                              Get.find<DashBoardController>().update();
                            },
                            deleteOnTap: () async {
                                controller.cardList.removeAt(index);
                                await localStorage.write('cardList',
                                    controller.cardList.map((folderInfo) => folderInfo.toJson()).toList());
                                controller.update();
                            },
                            editOnTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.k3D3D3D,
                                  icon: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () => Get.back(),
                                        icon: const Icon(
                                          Icons.cancel_outlined,
                                          color: AppColors.kFFFFFF,
                                        )),
                                  ),
                                  iconPadding: EdgeInsets.zero,
                                  actions: [
                                    Form(
                                        key: controller.formKey,
                                        child: Column(
                                          children: [
                                            TextFormFieldCommon(
                                              controller: controller.cardHolderNameController,
                                              hintText: 'card_holder_name'.tr,
                                              onChanged: (p0) {
                                                controller.update();
                                              },
                                            ),
                                            size.heightSpace(20),
                                            TextFormFieldCommon(
                                              controller: controller.cardNumberController,
                                              hintText: 'card_number'.tr,
                                              keyboardType: TextInputType.number,
                                              maxLength: 16,
                                              onChanged: (p0) {
                                                controller.update();
                                              },
                                            ),
                                            size.heightSpace(10),
                                            Row(
                                              children: [
                                                Expanded(child: TextFormFieldCommon(controller: controller.expiryDateController,
                                                  hintText: 'expiry_date'.tr,
                                                  maxLength: 5,
                                                  keyboardType: TextInputType.number,
                                                  onChanged: (input) {
                                                    if (input.length == 2 && !input.contains('/')) {
                                                      controller.expiryDateController.text = "$input/";
                                                      controller.expiryDateController.selection = TextSelection.fromPosition(
                                                        TextPosition(offset: controller.expiryDateController.text.length),
                                                      );
                                                    } else if (input.length == 2 && input.endsWith('/')) {
                                                      controller.expiryDateController.text = input.substring(0, 1);
                                                      controller.expiryDateController.selection = TextSelection.fromPosition(
                                                        TextPosition(offset: controller.expiryDateController.text.length),
                                                      );
                                                    }
                                                  },
                                                )),
                                                size.widthSpace(10),
                                                Expanded(child: TextFormFieldCommon(controller: controller.securityCodeController,
                                                  hintText: 'security_code'.tr,
                                                  keyboardType: TextInputType.number,
                                                  maxLength: 3,
                                                  onChanged: (p0) {
                                                    controller.update();
                                                  },
                                                )),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {

                                                String holderName = controller.cardHolderNameController.text;
                                                String cardNumber = controller.cardNumberController.text;
                                                String expiryDate = controller.expiryDateController.text;
                                                String securityCode = controller.securityCodeController.text;

                                                if(holderName.isNotEmpty && cardNumber.isNotEmpty && expiryDate.isNotEmpty && securityCode.isNotEmpty){

                                                  controller.cardList[index].cardHolderName = holderName;
                                                  controller.cardList[index].cardNumber = cardNumber;
                                                  controller.cardList[index].expiryDate = expiryDate;
                                                  controller.cardList[index].securityCode = securityCode;

                                                  await localStorage.write('cardList', controller.cardList.map((e) => e.toJson()).toList());
                                                  controller.update();
                                                }
                                                Get.back();
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: size.height(10),
                                                      horizontal: size.width(35)),
                                                decoration: BoxDecoration(
                                                  color: AppColors.k68D9A3,
                                                  borderRadius: BorderRadius.circular(5)),
                                                child: Text("Save",
                                                  style: AppTextStyle.semiBoldSmallText.copyWith(color: AppColors.k242424))),
                                            )
                                          ],
                                        )),
                                  ],
                                );
                              },);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
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
