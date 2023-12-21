import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/auth_controller.dart';
import 'package:docsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';

class PinSetScreen extends StatelessWidget {
  const PinSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<AuthController>(),
        builder: (controller) {
          return Scaffold(
            body: ScreenLock.create(
              onConfirmed: (value) {
                // controller.pinValue = value;
                // controller.update();
                // Get.find<AuthController>().update();
                localStorage.write('pin', value);
                Get.offAllNamed("/BottomBar");
                kDebugPrint("Value----> $value");
              },
            ),
          );
        });
  }
}

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<AuthController>(),
        builder: (controller) {
          return Scaffold(
              body: ScreenLock(
                  correctString: localStorage.read('pin'),
                  onUnlocked: () => Get.offNamed("/BottomBar")));
        });
  }
}
