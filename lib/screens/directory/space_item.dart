import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/image_path.dart';
import 'full_screen_img.dart';

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
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       child: AlertDialog(
                      //         backgroundColor: AppColors.k3D3D3D,
                      //         contentPadding: const EdgeInsets.only(
                      //             top: 0, left: 20, right: 20, bottom: 23),
                      //         iconPadding: EdgeInsets.zero,
                      //         icon: Align(
                      //           alignment: AlignmentDirectional.topEnd,
                      //           child: IconButton(
                      //               onPressed: () {
                      //                 Get.back();
                      //               },
                      //               icon: const Icon(
                      //                 Icons.cancel_outlined,
                      //                 color: AppColors.kFFFFFF,
                      //               )),
                      //         ),
                      //         content: Column(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             TextFormFieldCommon(
                      //               hintText: 'folder_name'.tr,
                      //               controller: controller.folderNameController,
                      //             ),
                      //             size.heightSpace(15),
                      //             GestureDetector(
                      //               onTap: () {
                      //                 // controller.createFolder();
                      //                 // controller.folderNameController.clear();
                      //               },
                      //               child: Container(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     vertical: 10, horizontal: 35),
                      //                 decoration: BoxDecoration(
                      //                   color: AppColors.k68D9A3,
                      //                   borderRadius: BorderRadius.circular(5),
                      //                 ),
                      //                 child: Text(
                      //                   'create_folder'.tr,
                      //                   style: AppTextStyle.semiBoldSmallText
                      //                       .copyWith(color: AppColors.k242424),
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.spaceAround,
                              backgroundColor: AppColors.k3D3D3D,
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    controller.pickImageInGallery();
                                  },
                                  child: const Text(
                                    "Gallery",
                                    style: TextStyle(
                                        color: AppColors.kFFFFFF,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    controller.pickImageInCamera();
                                  },
                                  child: const Text("Camera",
                                      style: TextStyle(
                                          color: AppColors.kFFFFFF,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(AppImagePath.newFileImg)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Gallery'),
                                  onTap: () {
                                    controller.getVideo(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo_camera),
                                  title: const Text('Camera'),
                                  onTap: () {
                                    controller.getVideo(ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                      child: const Icon(Icons.video_camera_back_outlined, color: AppColors.k6167DE,)),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: controller
                      .folderList![controller.selectedIndex].files!.isEmpty
                  ? Center(
                      child: SvgPicture.asset(
                        'assets/images/ic_empty_screen.svg',
                        height: size.height(303),
                        width: size.width(303),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return size.heightSpace(5);
                        },
                        shrinkWrap: true,
                        itemCount: controller
                                .folderList?[controller.selectedIndex]
                                .files
                                ?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: controller
                                        .folderList?[controller.selectedIndex]
                                        .files?[index]
                                        .mimeType ==
                                    'pdf'
                                ? Icon(Icons.picture_as_pdf_sharp,
                                    color: AppColors.k676D75,
                                    size: size.height(30))
                                : Icon(Icons.image,
                                    color: AppColors.k676D75,
                                    size: size.height(30)),
                            onTap: () {
                              Get.to(FullScreenImgScreen(
                                imageFile:
                                    "${controller.folderList?[controller.selectedIndex].files?[index].base64}",
                                index: index,
                              ));
                            },
                            title: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.folderList?[controller.selectedIndex].files?[index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.boldRegularText
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${controller.folderList?[controller.selectedIndex].createdAt}',
                                        style: AppTextStyle.mediumRegularText
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
                      )),
            ));
      },
    );
  }
}
