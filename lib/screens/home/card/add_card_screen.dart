import 'package:awesome_card/awesome_card.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CardController>(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.k23242E,
          elevation: 0,
          leading: IconButton(onPressed: () {
            Get.back();
          }, icon: const Icon(Icons.arrow_back,color: AppColors.kFFFFFF,)),
          title: Text('add_card'.tr,style: AppTextStyle.semiBoldMediumRegularText,),
        ),
        backgroundColor: AppColors.k23242E,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.k3D3D3D,
                      titleTextStyle: TextStyle(
                        fontSize: size.height(25)
                      ),
                      iconPadding: EdgeInsets.zero,
                      icon: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppColors.k68D9A3,
                            )),
                      ),
                      title: Text("The_scan_functionality_will_be_available_soon,_Please_add_the_card_manually.".tr, textAlign: TextAlign.center, style: AppTextStyle.normalRegularText,),
                    );
                  },);
                },child: Padding(
                  padding: EdgeInsets.only(left: size.width(10)),
                  child: SvgPicture.asset('assets/images/ic_scan_card.svg'),
                )),
                  size.heightSpace(20),
                  Form(
                      key: controller.formKey,
                      child: Column(
                    children: [
                      TextFormFieldCommon(
                        controller: controller.cardHolderNameController,
                      hintText: 'card_holder_name'.tr,
                      validator: (value) {
                        if(value.isEmpty){
                          return "enter_holder_name".tr;
                        } else {
                          return null;
                        }
                      },
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
                        validator: (value) {
                          if(value.isEmpty){
                            return "enter_card_number".tr;
                          } else if(value.length != 16){
                            return "enter_16_digits".tr;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (input) {
                          controller.update();
                        },
                      ),
                      size.heightSpace(20),
                      Row(
                        children: [
                          Expanded(child: TextFormFieldCommon(controller: controller.expiryDateController,
                            hintText: 'expiry_date'.tr,
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if(value.isEmpty){
                                return "enter_expiry_date".tr;
                              } else {
                                return null;
                              }
                            },
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
                          Expanded(child: TextFormFieldCommon(
                            controller: controller.securityCodeController,
                            hintText: 'security_code'.tr,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            validator: (value) {
                              if(value.isEmpty){
                                return "enter_security_code".tr;
                              }else if(value.length != 3){
                                return "Enter 3 Digits";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (p0) {
                              controller.update();
                            },
                          )),
                        ],
                      )
                    ],
                  )),
                size.heightSpace(20),
                GestureDetector(
                  onTap: () {
                    controller.isCardFlip = !controller.isCardFlip;
                    controller.update();
                  },
                  child: CreditCard(
                      cardNumber: controller.cardNumberController.text,
                      cardExpiry: controller.expiryDateController.text,
                      cardHolderName: controller.cardHolderNameController.text,
                      cvv: controller.securityCodeController.text,
                      showBackSide: controller.isCardFlip,
                      backTextColor: AppColors.kFFFFFF,
                      frontBackground: CardBackgrounds.custom(0XFFB370DD),
                      backBackground: CardBackgrounds.custom(0XFFB370DD)),
                )
                // CreditCardWidget(
                //   cardNumber: controller.cardNumberController.text,
                //   expiryDate: controller.expiryDateController.text,
                //   cardHolderName: controller.cardHolderNameController.text,
                //   cvvCode: controller.securityCodeController.text,
                //   showBackView: false,
                //   isChipVisible: false,padding: 10,isHolderNameVisible: true,
                //   cardBgColor: AppColors.kB370DD,
                //   onCreditCardWidgetChange: (CreditCardBrand brand) {}, // Callback for anytime credit card brand is changed
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            controller.createCard();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 80,
            color: AppColors.k23242E,
            child: Container(
              height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.k6167DE,
                  border: Border.all(color: AppColors.kFFFFFF,width: 2)
                ),
                child: Center(child: Text('save_to_wallet'.tr,style: AppTextStyle.semiBoldRegularText.copyWith(color: AppColors.kFFFFFF),))),
          ),
        ),
      );
    },);
  }
}
