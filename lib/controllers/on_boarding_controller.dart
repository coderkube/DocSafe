import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  @override
  void onInit() {
    pageController = PageController(
      viewportFraction: 1,
    );
    super.onInit();
  }

  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  int currentIndex = 0;
}
