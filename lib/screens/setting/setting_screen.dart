import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<SettingController>(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.k23242E,
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: size.height(25)),
              margin: EdgeInsets.only(
                top: size.height(100),
                left: size.width(25),
                right: size.width(25)),
              decoration: const BoxDecoration(
                color: AppColors.k3D3D3D,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              ),
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png", height: size.height(80)),
                  size.heightSpace(10),
                  Text('DocSafe',
                    style: TextStyle(
                    fontSize: size.height(20),
                    color: AppColors.kFFFFFF,
                    fontWeight: FontWeight.w600)),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.language, color: AppColors.k68D9A3,),
                    title: Text('language'.tr, style: const TextStyle(color: AppColors.kFFFFFF),),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: AppColors.k3D3D3D,
                        context: context, builder: (context) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height(10),
                            horizontal: size.width(5)
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('हिंदी', style: TextStyle(color: AppColors.kFFFFFF),),
                                onTap: () {
                                  controller.setLocale('hi', 'IN');
                                  Get.back();
                                },
                              ),
                              ListTile(
                                title: const Text('English', style: TextStyle(color: AppColors.kFFFFFF),),
                                onTap: () {
                                  controller.setLocale('en', 'US');
                                  Get.back();
                                },
                              )
                            ],
                          ),
                        );
                      },);
                    },
                  ),
                  // ListTile(
                  //     onTap: () {
                  //     },
                  //     leading: const Icon(Icons.fingerprint, color: AppColors.k68D9A3,),
                  //     title: const Text('Finger Print', style: TextStyle(color: AppColors.kFFFFFF),)),
                  // ListTile(
                  //   onTap: () async {
                  //     await Supabase.instance.client.auth.signOut();
                  //     Get.offNamed("/SignIn");
                  //   },
                  //     leading: const Icon(Icons.logout, color: AppColors.k68D9A3,),
                  //     title: const Text('Sign Out', style: TextStyle(color: AppColors.kFFFFFF),)),
                ],
              ),
            )
          ],
        )
      );
    },);
  }
}