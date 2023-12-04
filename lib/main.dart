import 'package:docsafe/config/localization.dart';
import 'package:docsafe/config/root_binding.dart';
import 'package:docsafe/screens/auth/sign_in_screen.dart';
import 'package:docsafe/screens/auth/welcome_screen.dart';
import 'package:docsafe/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: RootBinding(),
      translations: Localization(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      fallbackLocale: const Locale("en", "US"),
      theme: ThemeData(
        fontFamily: "Barlow"
      ),
      home: const SignInScreen(),
    );
  }
}