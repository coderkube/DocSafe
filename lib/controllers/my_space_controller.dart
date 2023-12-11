import 'dart:convert';
import 'dart:io';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/models/folder_info.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class MySpaceController extends GetxController {
  final ScrollController scrollController = ScrollController();

  TextEditingController folderNameController = TextEditingController();

  bool isListView = true;
  bool isEmptyData = true;

  List<FolderInfo> folderList = [];

  String? popUpMenuInitialValue;

  Future getStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isDenied ||
          await Permission.manageExternalStorage.isPermanentlyDenied ||
          await Permission.manageExternalStorage.isRestricted ||
          await Permission.accessMediaLocation.isDenied ||
          await Permission.accessMediaLocation.isPermanentlyDenied ||
          await Permission.accessMediaLocation.isRestricted) {
        print("Restricted");
        await Permission.manageExternalStorage.request();
        await Permission.accessMediaLocation.request();
        // await Permission.storage.request();
      }
    } else if (Platform.isIOS) {
      if (await Permission.photos.isDenied ||
          await Permission.photos.isPermanentlyDenied ||
          await Permission.photos.isRestricted ||
          await Permission.manageExternalStorage.isDenied ||
          await Permission.manageExternalStorage.isPermanentlyDenied ||
          await Permission.manageExternalStorage.isRestricted ||
          await Permission.accessMediaLocation.isDenied ||
          await Permission.accessMediaLocation.isPermanentlyDenied ||
          await Permission.accessMediaLocation.isRestricted) {
        await Permission.manageExternalStorage.request();
        await Permission.accessMediaLocation.request();
        await Permission.photos.request();
      }
    }
  }

  Future<void> createFolder() async {
    String folderName = folderNameController.text;
    await getStoragePermission();
    Directory externalDir = Directory("storage/emulated/0");
    String folderPath = "${externalDir.path}/$folderName";
    final path = Directory(folderPath);
    if (await path.exists()) {
      kDebugPrint("Folder already exists");
    } else {
      isEmptyData = false;
      update();
      await path.create();
      folderList.add(FolderInfo(folderName, DateTime.now()));
      await localStorage.write('folderList', folderList.map((folderInfo) => folderInfo.toJson()).toList());
      Get.back();
      kDebugPrint("======Folder created successfully");
    }
  }
}
