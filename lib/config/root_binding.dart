import 'package:docsafe/controllers/auth_controller.dart';
import 'package:docsafe/controllers/on_boarding_controller.dart';
import 'package:docsafe/controllers/splash_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(OnBoardingController());
    Get.put(SplashController());
  }
}
