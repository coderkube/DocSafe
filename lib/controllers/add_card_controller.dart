import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/dash_board_controller.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();

  final ScrollController scrollController = ScrollController();

  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();

  List<CardModel> cardList = [];
  List<CardModel> pinCardList = [];

  bool isCardFlip = true;

  int selectedIndex = 0;

  Future<void> createCard() async {
    if(formKey.currentState!.validate()){
      Map<String, dynamic> data = {
        "cardHolderName": cardHolderNameController.text,
        "cardNumber": cardNumberController.text,
        "expiryDate": expiryDateController.text,
        "securityCode": securityCodeController.text,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString()
      };

      CardModel cardData = CardModel.fromJson(data);
      kDebugPrint("cardData======${cardData.cardHolderName}");

      cardList.add(cardData);
      kDebugPrint("CardList-----$cardList");

      await localStorage.write('cardList',
          cardList.map((cardInfo) => cardInfo.toJson()).toList());

      cardHolderNameController.clear();
      cardNumberController.clear();
      expiryDateController.clear();
      securityCodeController.clear();

      update();
      Get.find<DashBoardController>().update();
      Get.back();
      kDebugPrint("======Card created successfully");
    }
  }

  Future<void> cardScanner() async {
    var cardDetails = await CardScanner.scanCard(
      scanOptions: const CardScanOptions(
        scanCardHolderName: true,
      )
    );
    cardHolderNameController.text = cardDetails!.cardHolderName;
    cardNumberController.text = cardDetails.cardNumber;
    expiryDateController.text = cardDetails.expiryDate;
  }
}
