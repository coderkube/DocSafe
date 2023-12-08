import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySpaceController extends GetxController {

  final ScrollController scrollController = ScrollController();

  bool isListView = true;

  String? popUpMenuInitialValue;
}