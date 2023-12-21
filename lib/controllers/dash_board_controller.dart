import 'package:docsafe/controllers/add_card_controller.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:docsafe/main.dart';
import 'package:docsafe/models/card_model.dart';
import 'package:docsafe/models/folder_detail_model.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  @override
  void onInit() {
    Get.find<MySpaceController>().pinFolderList =
        (localStorage.read('pinFolderList') as List<dynamic>?)
                ?.map((e) => DocModel.fromJson(Map<String, dynamic>.from(e)))
                .toList() ??
            [];

    Get.find<CardController>().pinCardList =
        (localStorage.read('pinCardList') as List<dynamic>?)
                ?.map((e) => CardModel.fromJson(Map<String, dynamic>.from(e)))
                .toList() ??
            [];
    super.onInit();
  }
}
