// ignore_for_file: prefer_const_constructors

import 'package:docsafe/components/pop_up_menu.dart';
import 'package:docsafe/components/textformfield.dart';
import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/image_path.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:docsafe/controllers/my_space_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<MySpaceController>(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.k23242E,
          elevation: 0,
          title: Text('my_space'.tr,style: AppTextStyle.semiBoldMediumRegularText),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImagePath.newFolderImg,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImagePath.newFileImg),
            ),
            InkWell(
              onTap: () {
                if(controller.isListView == true){
                  controller.isListView = false;
                  controller.update();
                }else{
                  controller.isListView = true;
                  controller.update();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: controller.isListView ? SvgPicture.asset(AppImagePath.gridImg) : SvgPicture.asset(AppImagePath.listImg),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.k23242E,
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: controller.isEmptyData ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: SvgPicture.asset('assets/images/ic_empty_screen.svg')),
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
                              contentPadding: EdgeInsets.only(top: 0,left: 20,right: 20,bottom: 23),
                              iconPadding: EdgeInsets.zero,
                              icon: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: IconButton(onPressed: () {
                                Get.back();
                              }, icon: Icon(Icons.cancel_outlined,color: AppColors.kFFFFFF,)),
                            ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormFieldCommon(
                                    hintText: 'folder_name'.tr,
                                    controller: controller.folderNameController,
                                  ),
                                  size.heightSpace(15),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),
                                    decoration: BoxDecoration(
                                      color: AppColors.k68D9A3,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text('create_folder'.tr,style: AppTextStyle.semiBoldSmallText.copyWith(color: AppColors.k242424),),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 73),
                      decoration: BoxDecoration(
                        color: AppColors.k6167DE,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text('add_file_or_folder'.tr,style: AppTextStyle.semiBoldMediumRegularText.copyWith(color: AppColors.kFFFFFF),),
                    ),
                  )
                ],
              )
              :Container(
            padding: const EdgeInsets.only(top: 10),
            child: controller.isListView == true ?
            ListView.separated(
              separatorBuilder: (context, index) {
                return size.heightSpace(5);
              },
              shrinkWrap: true,
              controller: controller.scrollController,
              itemCount: 10,
              itemBuilder: (context, index) {
              return ListTile(
                leading: SvgPicture.asset(AppImagePath.draggerImg),
                title: Row(
                  children: [
                    SvgPicture.asset(AppImagePath.folderImg),
                    size.widthSpace(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lorem lobby',style: AppTextStyle.boldRegularText.copyWith(fontWeight: FontWeight.w500,fontSize: 14),),
                        Text('Created on 24-12-2023 (11:45:09) ',style: AppTextStyle.mediumRegularText.copyWith(fontWeight: FontWeight.w300,fontSize: 10),)
                      ],
                    )
                  ],
                ),
                trailing: PopUpButtonCommon(
                  onSelected: (value) {
                    controller.popUpMenuInitialValue = value;
                    controller.update();
                   },
                ),
              );
            },) : Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: GridView.builder(
                itemCount: 5,
                controller: controller.scrollController,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 15),
                itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.k3D3D3D
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(AppImagePath.folderImg),
                          PopUpButtonCommon(
                            onSelected: (value) {
                              controller.popUpMenuInitialValue = value;
                              controller.update();
                            },
                          ),
                        ],
                      ),
                      size.heightSpace(10),
                      Text('Lorem lobby',style: AppTextStyle.boldRegularText.copyWith(fontWeight: FontWeight.w500,fontSize: 14),),
                      Text('Created on 24-12-2023 (11:45:09) ',style: AppTextStyle.mediumRegularText.copyWith(fontWeight: FontWeight.w300,fontSize: 10),)
                    ],
                  ),
                );
              },),
            ),
          ),
        ),
      );
    },);
  }
}
