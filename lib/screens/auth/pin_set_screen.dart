import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';

class PinSetScreen extends StatelessWidget {
  const PinSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenLock.create(
        onConfirmed: (value) {
          Get.offAllNamed("/BottomBar");
        },),
    );
  }
}

