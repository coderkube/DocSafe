import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingController extends GetxController {
  @override
  void onInit() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentIndex < 2) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      }
      update();
    });

    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  PageController pageController = PageController(initialPage: 0);
  Timer? timer;
  int currentIndex = 0;
}
