import 'package:docsafe/screens/home/dashboard_screen.dart';
import 'package:docsafe/screens/setting/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomNaviBarController extends GetxController {
  int selectedIndex = 0;

  List<Widget> screens = [
    const DashBoardScreen(),
    const SettingScreen(),
    const SettingScreen(),
    const SettingScreen(),
  ];

  Future<bool> onWillPop() async {
    if (selectedIndex != 0) {
      selectedIndex = 0;
      update();
      return false;
    }
    return true;
  }
}
