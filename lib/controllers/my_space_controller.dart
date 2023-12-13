import 'dart:convert';
import 'dart:io';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/models/folder_detail_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class MySpaceController extends GetxController {

  // @override
  // void onInit() {
  //   videoPlayerController = VideoPlayerController.file(File(videoFile.toString()));
  //   videoPlayerController?.initialize().then((value){
  //     videoPlayerController?.play();
  //     update();
  //   });
  //   initializeVideoPlayerFuture = videoPlayerController?.initialize();
  //   super.onInit();
  // }
  // getinitil(){
  //
  //   kDebugPrint(
  //       "url ::--$videoFile"
  //   );
  //   videoPlayerController = VideoPlayerController.file(File(videoFile.toString()));
  //    videoPlayerController?.initialize().then((value){
  //     videoPlayerController?.play();
  //   });
  //
  // }

  // @override
  // void dispose() {
  //   videoPlayerController?.dispose();
  //   super.dispose();
  // }

  final ScrollController scrollController = ScrollController();

  TextEditingController folderNameController = TextEditingController();
  // VideoPlayerController? videoPlayerController;
  // Future<void>? initializeVideoPlayerFuture;

  bool isListView = true;
  bool isTrue = true;

  int selectedIndex = 0;

  final picker = ImagePicker();
  FilePickerResult? result;

  List<DocModel>? folderList;
  File? videoFile;

  String? popUpMenuInitialValue;
  String? base64Image;
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
    await getStoragePermission();
    Map<String, dynamic> data = {
      "name": folderNameController.text,
      "type": "folder",
      "files": [],
      "createdAt": DateTime.now().toString(),
      "updatedAt": DateTime.now().toString()
    };

    DocModel data2 = DocModel.fromJson(data);

    folderList?.add(data2);

    await localStorage.write('folderList',
        folderList?.map((folderInfo) => folderInfo.toJson()).toList());
    update();
    Get.back();
    kDebugPrint("======Folder created successfully");
  }

  Future pickImageInGallery() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      kDebugPrint('Image: $image');
      final bytes = await image.readAsBytes();
      base64Image = base64Encode(bytes);

      Map<String, dynamic> imageData = {
        "mimeType": pickedFile.mimeType,
        "base64": base64Image,
        "name": pickedFile.name
      };

      Files jsonData = Files.fromJson(imageData);

      folderList?[selectedIndex].files?.add(jsonData);

      await localStorage.write('folderList',
          folderList?.map((folderInfo) => folderInfo.toJson()).toList());
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

      kDebugPrint('Image: $image');
      final bytes = await image.readAsBytes();
      base64Image = base64Encode(bytes);

      Map<String, dynamic> uploadData = {
        "mimeType": pickedFile.mimeType,
        "base64": base64Image,
        "name": pickedFile.name
      };

      Files fileData = Files.fromJson(uploadData);

      folderList?[selectedIndex].files?.add(fileData);
      await localStorage.write(
          'folderList', folderList?.map((e) => e.toJson()).toList());
    } else {
      kDebugPrint('No image selected');
    }
    update();
  }

  void pickFiles() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File("${result?.files.single.path}");
      final bytes = await file.readAsBytes();
      base64Image = base64Encode(bytes);

      Map<String, dynamic> uploadData = {
        "mimeType": 'pdf',
        "base64": base64Image,
        "name": result?.files.single.name
      };

      Files fileData = Files.fromJson(uploadData);
      folderList?[selectedIndex].files?.add(fileData);
      await localStorage.write(
          'folderList', folderList?.map((e) => e.toJson()).toList());
    } else {
      kDebugPrint("----> No file selected");
    }
    update();
  }

  // Future getVideo(ImageSource img) async {
  //   final pickedFile = await picker.pickVideo(
  //       source: img,
  //       preferredCameraDevice: CameraDevice.front,
  //       maxDuration: const Duration(minutes: 10));
  //   XFile? filePick = pickedFile;
  //
  //   if (filePick != null) {
  //     videoFile = File(pickedFile!.path);
  //
  //     Map<String, dynamic> uploadData = {
  //       "mimeType": 'mp4',
  //       "base64": base64Image,
  //       "name": filePick.name
  //     };
  //
  //     Files fileData = Files.fromJson(uploadData);
  //     folderList?[selectedIndex].files?.add(fileData);
  //     kDebugPrint("===> galleryFile : $videoFile");
  //   } else {
  //     kDebugPrint("----> No selected Video");
  //   }
  //   update();
  // }
}
