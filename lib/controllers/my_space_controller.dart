import 'dart:io';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/models/folder_detail_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MySpaceController extends GetxController {

  final ScrollController scrollController = ScrollController();

  final TextEditingController folderNameController = TextEditingController();

  bool isListView = true;
  bool isTrue = true;
  bool isPinList = false;

  int selectedIndex = 0;
  int selectedPinFolderIndex = 0;

  final picker = ImagePicker();
  FilePickerResult? result;

  List<DocModel> folderList = [];
  List<DocModel> pinFolderList = [];

  String? popUpMenuInitialValue;
  String? title;

  Future getStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isDenied ||
          await Permission.manageExternalStorage.isPermanentlyDenied ||
          await Permission.manageExternalStorage.isRestricted ||
          await Permission.accessMediaLocation.isDenied ||
          await Permission.accessMediaLocation.isPermanentlyDenied ||
          await Permission.accessMediaLocation.isRestricted) {
        kDebugPrint("Restricted");
        await Permission.manageExternalStorage.request();
        await Permission.accessMediaLocation.request();
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
    getStoragePermission();
    Map<String, dynamic> data = {
      "name": folderNameController.text,
      "type": "folder",
      "files": [],
      "isPinned": false,
      "createdAt": DateTime.now().toString(),
      "updatedAt": DateTime.now().toString()
    };

    DocModel data2 = DocModel.fromJson(data);

    folderList.add(data2);

    await localStorage.write('folderList',
        folderList.map((folderInfo) => folderInfo.toJson()).toList());

    update();
    folderNameController.clear();
    Get.back();
    kDebugPrint("======Folder created successfully");
  }

  Future pickImageInGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      Map<String, dynamic> imageData = {
        "mimeType": pickedFile.mimeType,
        "path": image.path,
        "name": pickedFile.name
      };

      Files jsonData = Files.fromJson(imageData);

      isPinList ?
      pinFolderList[selectedPinFolderIndex].files?.add(jsonData) :
      folderList[selectedIndex].files?.add(jsonData);

      isPinList ?
      await localStorage.write('pinFolderList', pinFolderList.map((folderInfo) => folderInfo.toJson()).toList()) :
      await localStorage.write('folderList', folderList.map((folderInfo) => folderInfo.toJson()).toList());

    } else {
      kDebugPrint('No image selected');
    }
    update();
  }

  Future pickImageInCamera() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      Map<String, dynamic> uploadData = {
        "mimeType": pickedFile.mimeType,
        "path": image.path,
        "name": pickedFile.name
      };

      Files fileData = Files.fromJson(uploadData);

      isPinList ?
      pinFolderList[selectedPinFolderIndex].files?.add(fileData) :
      folderList[selectedIndex].files?.add(fileData);

      isPinList ?
      await localStorage.write('pinFolderList', pinFolderList.map((folderInfo) => folderInfo.toJson()).toList()) :
      await localStorage.write('folderList', folderList.map((folderInfo) => folderInfo.toJson()).toList());
    } else {
      kDebugPrint('No image selected');
    }
    update();
  }

  void pickFiles() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File("${result?.files.single.path}");

      Map<String, dynamic> uploadData = {
        "mimeType": result?.files.single.extension,
        "path": file.path,
        "name": result?.files.single.name
      };
      Files fileData = Files.fromJson(uploadData);

      isPinList ?
      pinFolderList[selectedPinFolderIndex].files?.add(fileData) :
      folderList[selectedIndex].files?.add(fileData);

      isPinList ?
      await localStorage.write('pinFolderList', pinFolderList.map((folderInfo) => folderInfo.toJson()).toList()) :
      await localStorage.write('folderList', folderList.map((folderInfo) => folderInfo.toJson()).toList());

    } else {
      kDebugPrint("----> No file selected");
    }
    update();
  }

  void spaceScreenPickFiles() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File("${result?.files.single.path}");

      Map<String, dynamic> data = {
        "name": result?.files.single.name,
        "type": "file",
        "path": file.path,
        "isPinned": false,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString()
      };

      DocModel fileData = DocModel.fromJson(data);
      folderList.add(fileData);
      await localStorage.write('folderList', folderList.map((e) => e.toJson()).toList());
    } else {
      kDebugPrint("----> No file selected");
    }
    update();
  }
}
