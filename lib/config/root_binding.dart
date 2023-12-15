import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:docsafe/controllers/auth_controller.dart';
import 'package:docsafe/controllers/dash_board_controller.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:docsafe/controllers/bottom_navi_bar_controller.dart';
import 'package:docsafe/controllers/on_boarding_controller.dart';
import 'package:docsafe/controllers/setting_controller.dart';
import 'package:docsafe/controllers/splash_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(OnBoardingController());
    Get.put(SplashController());
    Get.put(MySpaceController());
    Get.put(BottomNaviBarController());
    Get.put(SettingController());
    Get.put(DashBoardController());
    Get.put(CardController());
  }
}
