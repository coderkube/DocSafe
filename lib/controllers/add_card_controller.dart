import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey();
  
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();
}