import 'package:docsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {

  void setLocale(String languageCode, String countryCode) {
    localStorage.write('languageCode', languageCode);
    localStorage.write('countryCode', countryCode);
    Get.updateLocale(Locale(languageCode, countryCode));
  }
}