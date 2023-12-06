import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () => Get.offNamed("/OnBoarding"),
    );
    super.onInit();
  }
}
