import 'dart:convert';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

class FullScreenImgScreen extends StatelessWidget {
  final String? imageFile;
  final int? index;

  const FullScreenImgScreen(
      {super.key, required this.imageFile, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<MySpaceController>(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: controller.folderList![controller.selectedIndex]
                          .files?[index!].mimeType ==
                      'pdf'
                  ? SfPdfViewer.memory(base64Decode(imageFile!))
                  : Image.memory(base64Decode(imageFile!))
            )
            // body: FutureBuilder(
            //   future: controller.initializeVideoPlayerFuture,
            //   builder: (context, snapshot) {
            //     return AspectRatio(
            //       aspectRatio: controller.videoPlayerController!.value.aspectRatio,
            //       child: GestureDetector(
            //           onTap: () {
            //             kDebugPrint('-==-=--=-=-=Tapped on video!');
            //             if (controller.videoPlayerController!.value.isPlaying) {
            //               controller.videoPlayerController?.pause();
            //             } else {
            //               controller.videoPlayerContr  oller?.play();
            //             }
            //           },
            //           child: VideoPlayer(controller.videoPlayerController!)),
            //     );
            //   },
            // ),
          );
        });
  }
}
