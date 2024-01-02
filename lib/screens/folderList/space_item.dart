import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import '../../config/image_path.dart';

class SpaceItemScreen extends StatelessWidget {
  const SpaceItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MySpaceController>(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.k23242E,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: AppColors.kFFFFFF,
              ),
              backgroundColor: AppColors.k23242E,
              elevation: 0,
              title: Text('my_space_item'.tr,
                  style: AppTextStyle.semiBoldMediumRegularText),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.pickFiles();
                    },
                    child: SvgPicture.asset(
                      AppImagePath.newFolderImg,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: AppColors.k3D3D3D,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                controller.pickImageInGallery();
                                                Get.back();
                                              },
                                              child: Icon(
                                                Icons.photo,
                                                size: size.height(40),
                                                color: AppColors.k6167DE,
                                              )),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(
                                                fontSize: size.height(20),
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.kFFFFFF),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.pickImageInCamera(context);
                                              Get.back();
                                            },
                                            child: Icon(
                                                Icons.camera_alt_outlined,
                                                size: size.height(40),
                                                color: AppColors.k6167DE),
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(
                                                fontSize: size.height(20),
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.kFFFFFF),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(AppImagePath.newFileImg)),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child:
              Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          controller.isPinList
                              ? controller.pinFolderList[controller.selectedPinFolderIndex].files!.isNotEmpty ?
                          ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return size.heightSpace(5);
                                  },
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .pinFolderList[controller.selectedPinFolderIndex]
                                      .files!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: controller
                                                  .pinFolderList[
                                                      controller.selectedPinFolderIndex]
                                                  .files?[index]
                                                  .mimeType ==
                                              'pdf'
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width(3)),
                                              child: SvgPicture.asset(
                                                  AppImagePath.pdfImg),
                                            )
                                          : Icon(Icons.image,
                                              color: AppColors.k676D75,
                                              size: size.height(30)),
                                      onTap: () async {
                                        await OpenFile.open(
                                            "${controller.pinFolderList[controller.selectedPinFolderIndex].files?[index].path}");
                                      },
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.pinFolderList[controller.selectedPinFolderIndex].files?[index].name}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .boldRegularText
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.pinFolderList[controller.selectedPinFolderIndex].createdAt}',
                                                  style: AppTextStyle
                                                      .mediumRegularText
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ) :
                          Center(
                      child: SvgPicture.asset(
                        'assets/images/ic_empty_screen.svg',
                        height: size.height(303),
                        width: size.width(303),
                      ),
                    )
                              : controller.folderList[controller.selectedIndex].files!.isNotEmpty ?
                          ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return size.heightSpace(5);
                                  },
                                  shrinkWrap: true,
                                  itemCount: controller
                                          .folderList[controller.selectedIndex]
                                          .files
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: controller
                                                  .folderList[
                                                      controller.selectedIndex]
                                                  .files?[index]
                                                  .mimeType ==
                                              'pdf'
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width(3)),
                                              child: SvgPicture.asset(
                                                  AppImagePath.pdfImg),
                                            )
                                          : Icon(Icons.image,
                                              color: AppColors.k676D75,
                                              size: size.height(30)),
                                      onTap: () async {
                                        kDebugPrint("Open Space Item ======>${controller.folderList[controller.selectedIndex].files?[index].path}");
                                        await OpenFile.open(
                                            "${controller.folderList[controller.selectedIndex].files?[index].path}");
                                      },
                                      title: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.folderList[controller.selectedIndex].files?[index].name}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .boldRegularText
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.folderList[controller.selectedIndex].createdAt}',
                                                  style: AppTextStyle
                                                      .mediumRegularText
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ) :
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/ic_empty_screen.svg',
                              height: size.height(303),
                              width: size.width(303),
                            ),
                          ),
                        ],
                      )),
            ));
      },
    );
  }
}