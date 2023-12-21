import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:docsafe/controllers/bottom_navi_bar_controller.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/models/card_model.dart';
import 'package:docsafe/models/folder_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNaviBar extends StatelessWidget {
  const BottomNaviBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<BottomNaviBarController>(),
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: size.height(70),
            color: AppColors.k1D1F24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      controller.selectedIndex = 0;
                      controller.update();
                    },
                    child: controller.selectedIndex == 0
                        ? Container(
                            padding: EdgeInsets.all(size.height(12)),
                            decoration: BoxDecoration(
                                color: AppColors.k68D9A3.withOpacity(0.20),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImagePath.homeImg,
                              color: AppColors.k68D9A3,
                              height: size.height(24),
                              width: size.width(24),
                            ))
                        : SvgPicture.asset(
                            AppImagePath.homeImg,
                            color: AppColors.k676D75,
                            height: size.height(24),
                            width: size.width(24),
                          )),
                InkWell(
                    onTap: () {

                      // localStorage.remove('folderList');
                      // localStorage.remove('pinFolderList');

                      Get.find<MySpaceController>().folderList =
                          (localStorage.read('folderList') as List<dynamic>?)
                              ?.map((e) => DocModel.fromJson(
                              Map<String, dynamic>.from(e)))
                              .toList() ??
                              [];

                      Get.find<MySpaceController>().pinFolderList =
                          (localStorage.read('pinFolderList') as List<dynamic>?)
                              ?.map((e) => DocModel.fromJson(
                              Map<String, dynamic>.from(e)))
                              .toList() ??
                              [];

                      Get.find<MySpaceController>().update();
                      controller.selectedIndex = 1;
                      controller.update();
                    },
                    child: controller.selectedIndex == 1
                        ? Container(
                            padding: EdgeInsets.all(size.height(12)),
                            decoration: BoxDecoration(
                              color: AppColors.k68D9A3.withOpacity(0.20),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              AppImagePath.naviBarFileImg,
                              color: AppColors.k68D9A3,
                              height: size.height(24),
                              width: size.width(24),
                            ))
                        : SvgPicture.asset(
                            AppImagePath.naviBarFileImg,
                            height: size.height(24),
                            width: size.width(24),
                          )),
                InkWell(
                    onTap: () {
                      controller.selectedIndex = 2;
                      controller.update();

                      // localStorage.remove('cardList');
                      // localStorage.remove('pinCardList');

                      Get.find<CardController>().cardList =
                          (localStorage.read('cardList') as List<dynamic>?)
                              ?.map((e) => CardModel.fromJson(
                              Map<String, dynamic>.from(e)))
                              .toList() ??
                              [];

                      Get.find<CardController>().pinCardList =
                          (localStorage.read('pinCardList') as List<dynamic>?)
                              ?.map((e) => CardModel.fromJson(
                              Map<String, dynamic>.from(e)))
                              .toList() ??
                              [];

                      Get.find<MySpaceController>().update();
                    },
                    child: controller.selectedIndex == 2
                        ? Container(
                            padding: EdgeInsets.all(size.height(12)),
                            decoration: BoxDecoration(
                                color: AppColors.k68D9A3.withOpacity(0.20),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImagePath.groupImg,
                              color: AppColors.k68D9A3,
                              height: size.height(24),
                              width: size.width(24),
                            ))
                        : SvgPicture.asset(
                            AppImagePath.groupImg,
                            height: size.height(24),
                            width: size.width(24),
                          )),
                InkWell(
                    onTap: () {
                      controller.selectedIndex = 3;
                      controller.update();
                    },
                    child: controller.selectedIndex == 3
                        ? Container(
                            padding: EdgeInsets.all(size.height(12)),
                            decoration: BoxDecoration(
                                color: AppColors.k68D9A3.withOpacity(0.20),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImagePath.settingImg,
                              color: AppColors.k68D9A3,
                              height: size.height(24),
                              width: size.width(24),
                            ))
                        : SvgPicture.asset(
                            AppImagePath.settingImg,
                            height: size.height(24),
                            width: size.width(24),
                          )),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              return await controller.onWillPop();
            },
            child: controller.screens[controller.selectedIndex],
          ),
        );
      },
    );
  }
}
