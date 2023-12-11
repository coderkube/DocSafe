import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySpaceController extends GetxController {

  final ScrollController scrollController = ScrollController();

  TextEditingController folderNameController = TextEditingController();

  bool isListView = true;
  bool isEmptyData = true;

  String? popUpMenuInitialValue;
}