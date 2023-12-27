// ignore_for_file: prefer_const_constructors
import 'package:docsafe/components/pop_up_menu.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/dash_board_controller.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:docsafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MySpaceController>(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: AppColors.kFFFFFF,
            ),
            backgroundColor: AppColors.k23242E,
            elevation: 0,
            title: Text('my_space'.tr,
                style: AppTextStyle.semiBoldMediumRegularText),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AlertDialog(
                            backgroundColor: AppColors.k3D3D3D,
                            contentPadding: EdgeInsets.only(
                                top: 0, left: 20, right: 20, bottom: 23),
                            iconPadding: EdgeInsets.zero,
                            icon: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: AppColors.kFFFFFF,
                                  )),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormFieldCommon(
                                  hintText: 'folder_name'.tr,
                                  controller: controller.folderNameController,
                                ),
                                size.heightSpace(15),
                                GestureDetector(
                                  onTap: () {
                                    controller.createFolder();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 35),
                                    decoration: BoxDecoration(
                                      color: AppColors.k68D9A3,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'create_folder'.tr,
                                      style: AppTextStyle.semiBoldSmallText
                                          .copyWith(color: AppColors.k242424),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    AppImagePath.newFolderImg,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  highlightColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () async {
                      controller.spaceScreenPickFiles();
                },child: SvgPicture.asset(AppImagePath.newFileImg)),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  if (controller.isListView == true) {
                    controller.isListView = false;
                    controller.update();
                  } else {
                    controller.isListView = true;
                    controller.update();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: controller.isListView
                      ? SvgPicture.asset(AppImagePath.gridImg)
                      : SvgPicture.asset(AppImagePath.listImg),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.k23242E,
          body: SingleChildScrollView(
            controller: controller.scrollController,
            child: (controller.folderList.isNotEmpty ||
                    controller.pinFolderList.isNotEmpty)
                ? Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: controller.isListView == true
                        ? Column(
                            children: [
                              ListView.separated(
                                separatorBuilder: (context, index) {
                                  return size.heightSpace(5);
                                },
                                shrinkWrap: true,
                                controller: controller.scrollController,
                                itemCount: controller.pinFolderList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () async {
                                      if(controller.pinFolderList[index].type == 'folder'){
                                        controller.selectedPinFolderIndex = index;
                                        controller.isPinList = true;
                                        kDebugPrint("-Select Index--> ${controller.selectedPinFolderIndex}");
                                        kDebugPrint("--Files-> ${controller.pinFolderList[index].files}");
                                        controller.update();
                                        Get.toNamed("/SpaceItem");
                                      } else {
                                        await OpenFile.open("${controller.pinFolderList[index].path}");
                                      }
                                    },
                                    leading: Icon(Icons.push_pin,
                                        size: size.height(17),
                                        color: AppColors.k68D9A3),
                                    title: Row(
                                      children: [
                                        controller.pinFolderList[index].type == 'folder' ?
                                        SvgPicture.asset(AppImagePath.folderImg) :
                                        SvgPicture.asset(AppImagePath.pdfImg),
                                        size.widthSpace(10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.pinFolderList[index].name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle
                                                    .boldRegularText
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "${controller.pinFolderList[index].createdAt}",
                                                style: AppTextStyle
                                                    .mediumRegularText
                                                    .copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: PopUpButtonCommon(
                                      pinText: 'unpin'.tr,
                                      onSelected: (value) {
                                        controller.popUpMenuInitialValue =
                                            value;
                                        controller.update();
                                      },
                                      pinOnTap: () async {
                                        controller.folderList.add(
                                            controller.pinFolderList[index]);
                                        await localStorage.write(
                                            'folderList',
                                            controller.folderList
                                                .map((e) => e.toJson())
                                                .toList());
                                        controller.pinFolderList
                                            .removeAt(index);
                                        await localStorage.write(
                                            'pinFolderList',
                                            controller.pinFolderList
                                                .map((e) => e.toJson())
                                                .toList());
                                        controller.update();
                                      },
                                      deleteOnTap: () async {
                                        controller.pinFolderList
                                            .removeAt(index);
                                        await localStorage.write(
                                            'pinFolderList',
                                            controller.pinFolderList
                                                .map((e) => e.toJson())
                                                .toList());
                                      },
                                      editOnTap: () {
                                        controller.folderNameController.text = controller.pinFolderList[index].name!;
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: AppColors.k3D3D3D,
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 23),
                                              iconPadding: EdgeInsets.zero,
                                              icon: Align(
                                                alignment:
                                                AlignmentDirectional.topEnd,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_outlined,
                                                      color: AppColors.kFFFFFF,
                                                    )),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormFieldCommon(
                                                    hintText: 'folder_name'.tr,
                                                    controller: controller
                                                        .folderNameController,
                                                  ),
                                                  size.heightSpace(15),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String newName = controller
                                                          .folderNameController.text;
                                                      if (newName.isNotEmpty) {
                                                        controller
                                                            .pinFolderList[index]
                                                            .name = newName;
                                                        await localStorage.write(
                                                            'pinFolderList',
                                                            controller.pinFolderList
                                                                .map((e) =>
                                                                e.toJson())
                                                                .toList());
                                                        controller.update();
                                                        Get.find<
                                                            DashBoardController>()
                                                            .update();
                                                      }
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 35),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.k68D9A3,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                      ),
                                                      child: Text(
                                                        'Edit Folder Name',
                                                        style: AppTextStyle
                                                            .semiBoldSmallText
                                                            .copyWith(
                                                            color: AppColors
                                                                .k242424),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              ListView.separated(
                                separatorBuilder: (context, index) {
                                  return size.heightSpace(5);
                                },
                                shrinkWrap: true,
                                controller: controller.scrollController,
                                itemCount: controller.folderList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () async {
                                      if(controller.folderList[index].type == 'folder'){
                                        controller.selectedIndex = index;
                                        controller.isPinList = false;
                                        controller.update();
                                        Get.toNamed("/SpaceItem");
                                      } else {
                                        await OpenFile.open("${controller.folderList[index].path}");
                                        kDebugPrint("---Click Event Path--- ${controller.folderList[index].path}");
                                      }
                                    },
                                    title: Row(
                                      children: [
                                        controller.folderList[index].type == 'folder' ?
                                        SvgPicture.asset(AppImagePath.folderImg) :
                                      SvgPicture.asset(AppImagePath.pdfImg),
                                        size.widthSpace(10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.folderList[index].name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle
                                                    .boldRegularText
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                "${controller.folderList[index].createdAt}",
                                                style: AppTextStyle
                                                    .mediumRegularText
                                                    .copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: PopUpButtonCommon(
                                      onSelected: (value) {
                                        controller.popUpMenuInitialValue = value;
                                        controller.update();
                                      },
                                      pinOnTap: () async {
                                        controller.pinFolderList.add(controller.folderList[index]);
                                        await localStorage.write('pinFolderList', controller.pinFolderList.map((e) => e.toJson()).toList());
                                        controller.folderList.removeAt(index);
                                        await localStorage.write('folderList', controller.folderList.map((e) => e.toJson()).toList());
                                        controller.update();
                                        Get.find<DashBoardController>().update();
                                      },
                                      deleteOnTap: () async {
                                        controller.folderList.removeAt(index);
                                        await localStorage.write(
                                            'folderList',
                                            controller.folderList
                                                .map((e) => e.toJson())
                                                .toList());
                                      },
                                      editOnTap: () {
                                        controller.folderNameController.text = controller.folderList[index].name!;
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: AppColors.k3D3D3D,
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 23),
                                              iconPadding: EdgeInsets.zero,
                                              icon: Align(
                                                alignment:
                                                AlignmentDirectional.topEnd,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_outlined,
                                                      color: AppColors.kFFFFFF,
                                                    )),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormFieldCommon(
                                                    hintText: 'folder_name'.tr,
                                                    controller: controller
                                                        .folderNameController,
                                                  ),
                                                  size.heightSpace(15),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      String newName = controller
                                                          .folderNameController.text;
                                                      if (newName.isNotEmpty) {
                                                        controller
                                                            .folderList[index]
                                                            .name = newName;
                                                        await localStorage.write(
                                                            'folderList',
                                                            controller.folderList
                                                                .map((e) =>
                                                                e.toJson())
                                                                .toList());
                                                        controller.update();
                                                        Get.find<
                                                            DashBoardController>()
                                                            .update();
                                                      }
                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 35),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.k68D9A3,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                      ),
                                                      child: Text(
                                                        'Edit Folder Name',
                                                        style: AppTextStyle
                                                            .semiBoldSmallText
                                                            .copyWith(
                                                            color: AppColors
                                                                .k242424),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                GridView.builder(
                                  itemCount: controller.pinFolderList.length,
                                  controller: controller.scrollController,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          mainAxisExtent: 115,
                                          crossAxisSpacing: 15),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if(controller.pinFolderList[index].type == 'folder'){
                                        controller.selectedPinFolderIndex = index;
                                        controller.isPinList = true;
                                        controller.update();
                                        Get.toNamed("/SpaceItem");
                                        } else {
                                          await OpenFile.open("${controller.pinFolderList[index].path}");
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.k3D3D3D),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                        controller.pinFolderList[index].type == 'folder' ?
                                        SvgPicture.asset(AppImagePath.folderImg) :
                                          SvgPicture.asset(AppImagePath.pdfImg),
                                                Icon(Icons.push_pin,
                                                    size: size.height(17),
                                                    color: AppColors.k68D9A3),
                                                PopUpButtonCommon(
                                                  pinText: "Unpin",
                                                  onSelected: (value) {
                                                    controller
                                                            .popUpMenuInitialValue =
                                                        value;
                                                    controller.update();
                                                  },
                                                  deleteOnTap: () async {
                                                    controller.pinFolderList.removeAt(index);
                                                    await localStorage.write('pinFolderList', controller.pinFolderList.map((e) => e.toJson()).toList());
                                                  },
                                                  pinOnTap: () {
                                                    controller.folderList.add(
                                                        controller
                                                                .pinFolderList[
                                                            index]);
                                                    controller.pinFolderList
                                                        .removeAt(index);
                                                    controller.update();
                                                  },
                                                  editOnTap: () {
                                                    controller.folderNameController.text = controller.pinFolderList[index].name!;
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor: AppColors.k3D3D3D,
                                                          contentPadding: EdgeInsets.only(
                                                              top: 0,
                                                              left: 20,
                                                              right: 20,
                                                              bottom: 23),
                                                          iconPadding: EdgeInsets.zero,
                                                          icon: Align(
                                                            alignment:
                                                            AlignmentDirectional.topEnd,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons.cancel_outlined,
                                                                  color: AppColors.kFFFFFF,
                                                                )),
                                                          ),
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              TextFormFieldCommon(
                                                                hintText: 'folder_name'.tr,
                                                                controller: controller
                                                                    .folderNameController,
                                                              ),
                                                              size.heightSpace(15),
                                                              GestureDetector(
                                                                onTap: () async {
                                                                  String newName = controller
                                                                      .folderNameController.text;
                                                                  if (newName.isNotEmpty) {
                                                                    controller
                                                                        .pinFolderList[index]
                                                                        .name = newName;
                                                                    await localStorage.write(
                                                                        'folderList',
                                                                        controller.pinFolderList.map((e) =>
                                                                            e.toJson())
                                                                            .toList());
                                                                    controller.update();
                                                                    Get.find<
                                                                        DashBoardController>()
                                                                        .update();
                                                                  }
                                                                  Get.back();
                                                                },
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: 10,
                                                                      horizontal: 35),
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.k68D9A3,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                                  ),
                                                                  child: Text(
                                                                    'Edit Folder Name',
                                                                    style: AppTextStyle
                                                                        .semiBoldSmallText
                                                                        .copyWith(
                                                                        color: AppColors
                                                                            .k242424),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            size.heightSpace(10),
                                            Text(
                                              "${controller.pinFolderList[index].name}",
                                              style: AppTextStyle
                                                  .boldRegularText
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "${controller.pinFolderList[index].createdAt}",
                                              style: AppTextStyle
                                                  .mediumRegularText
                                                  .copyWith(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                size.heightSpace(15),
                                GridView.builder(
                                  itemCount: controller.folderList.length,
                                  controller: controller.scrollController,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 15,
                                          mainAxisExtent: 115,
                                          crossAxisSpacing: 15),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if(controller.folderList[index].type == 'folder'){
                                        controller.selectedIndex = index;
                                        controller.isPinList = false;
                                        controller.update();
                                        Get.toNamed("/SpaceItem");
                                        } else {
                                          await OpenFile.open("${controller.folderList[index].path}");
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.k3D3D3D),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                controller.folderList[index].type == 'folder' ?
                                                SvgPicture.asset(
                                                    AppImagePath.folderImg) :
                                                SvgPicture.asset(AppImagePath.pdfImg, height: size.height(30)),
                                                PopUpButtonCommon(
                                                  onSelected: (value) {
                                                    controller
                                                            .popUpMenuInitialValue =
                                                        value;
                                                    controller.update();
                                                  },
                                                  deleteOnTap: () async {
                                                    controller.folderList.removeAt(index);
                                                    await localStorage.write('folderList', controller.folderList.map((e) => e.toJson()).toList());
                                                  },
                                                  pinOnTap: () async {
                                                    controller.pinFolderList.add(controller.folderList[index]);
                                                    await localStorage.write(
                                                        'pinFolderList',
                                                        controller.pinFolderList
                                                            .map((e) =>
                                                                e.toJson())
                                                            .toList());
                                                    controller.folderList
                                                        .removeAt(index);
                                                    await localStorage.write('folderList', controller.folderList.map((e) => e.toJson()).toList());
                                                    controller.update();
                                                  },
                                                  editOnTap: () {
                                                    controller.folderNameController.text = controller.folderList[index].name!;
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor: AppColors.k3D3D3D,
                                                          contentPadding: EdgeInsets.only(
                                                              top: 0,
                                                              left: 20,
                                                              right: 20,
                                                              bottom: 23),
                                                          iconPadding: EdgeInsets.zero,
                                                          icon: Align(
                                                            alignment:
                                                            AlignmentDirectional.topEnd,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons.cancel_outlined,
                                                                  color: AppColors.kFFFFFF,
                                                                )),
                                                          ),
                                                          content: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              TextFormFieldCommon(
                                                                hintText: 'folder_name'.tr,
                                                                controller: controller
                                                                    .folderNameController,
                                                              ),
                                                              size.heightSpace(15),
                                                              GestureDetector(
                                                                onTap: () async {
                                                                  String newName = controller
                                                                      .folderNameController.text;
                                                                  if (newName.isNotEmpty) {
                                                                    controller
                                                                        .folderList[index]
                                                                        .name = newName;
                                                                    await localStorage.write(
                                                                        'folderList',
                                                                        controller.folderList
                                                                            .map((e) =>
                                                                            e.toJson())
                                                                            .toList());
                                                                    controller.update();
                                                                    Get.find<
                                                                        DashBoardController>()
                                                                        .update();
                                                                  }
                                                                  Get.back();
                                                                },
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: 10,
                                                                      horizontal: 35),
                                                                  decoration: BoxDecoration(
                                                                    color: AppColors.k68D9A3,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                                  ),
                                                                  child: Text(
                                                                    'Edit Folder Name',
                                                                    style: AppTextStyle
                                                                        .semiBoldSmallText
                                                                        .copyWith(
                                                                        color: AppColors
                                                                            .k242424),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            size.heightSpace(10),
                                            Text(
                                              "${controller.folderList[index].name}",
                                              style: AppTextStyle
                                                  .boldRegularText
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "${controller.folderList[index].createdAt}",
                                              style: AppTextStyle
                                                  .mediumRegularText
                                                  .copyWith(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: SvgPicture.asset(
                              'assets/images/ic_empty_screen.svg')),
                      size.heightSpace(40),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: AlertDialog(
                                  backgroundColor: AppColors.k3D3D3D,
                                  contentPadding: EdgeInsets.only(
                                      top: 0, left: 20, right: 20, bottom: 23),
                                  iconPadding: EdgeInsets.zero,
                                  icon: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: AppColors.kFFFFFF,
                                        )),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormFieldCommon(
                                        hintText: 'folder_name'.tr,
                                        controller:
                                            controller.folderNameController,
                                      ),
                                      size.heightSpace(15),
                                      GestureDetector(
                                        onTap: () {
                                          controller.createFolder();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 35),
                                          decoration: BoxDecoration(
                                            color: AppColors.k68D9A3,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'create_folder'.tr,
                                            style: AppTextStyle
                                                .semiBoldSmallText
                                                .copyWith(
                                                    color: AppColors.k242424),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 73),
                          decoration: BoxDecoration(
                              color: AppColors.k6167DE,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            'add_file_or_folder'.tr,
                            style: AppTextStyle.semiBoldMediumRegularText
                                .copyWith(color: AppColors.kFFFFFF),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}
