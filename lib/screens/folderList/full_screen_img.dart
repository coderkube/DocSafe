// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:docsafe/controllers/my_space_controller.dart';
//
// class FullScreenImgScreen extends StatelessWidget {
//   final String? imageFile;
//   final int? index;
//
//   const FullScreenImgScreen(
//       {super.key, required this.imageFile, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//         init: Get.find<MySpaceController>(),
//         builder: (controller) {
//           return Scaffold(
//               appBar: AppBar(),
//               body: Container(
//                 child: OpenFile.open("$imageFile"),
//               )
//               // body: Center(
//               //   child:
//               //     controller.folderList![controller.selectedIndex]
//               //                 .files?[index!].mimeType == controller.result?.files.single.extension
//               //         ?
//               //     SfPdfViewer.memory(base64Decode("$imageFile"))
//               //         : Image.memory(base64Decode(imageFile!))
//               // ));
//         });
//   }
// }
