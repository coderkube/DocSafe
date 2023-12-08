import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpButtonCommon extends StatelessWidget {
  final void Function(String)? onSelected;
  const PopUpButtonCommon({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor:
        AppColors.kBlack38, fontFamily: "Barlow"
      ),
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.more_vert_rounded,
            size: 24,
            color: AppColors.kFFFFFF),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(10)),
        color: AppColors.k111111,
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: 'Option 1',
                child: Text(
                  'rename'.tr,
                  style: AppTextStyle
                      .boldRegularText
                      .copyWith(
                      fontWeight: FontWeight.w500),
                )),
            PopupMenuItem(
                value: "Option 2",
                child: Text(
                  'pin'.tr,
                  style: AppTextStyle
                      .boldRegularText
                      .copyWith(
                      fontWeight: FontWeight.w500),
                )),
            PopupMenuItem(
                value: "Option 3",
                child: Text(
                  'delete'.tr,
                  style: AppTextStyle
                      .boldRegularText
                          .copyWith(
                          fontWeight: FontWeight.w500),
                )),
          ];
        },
      ),
    );
  }
}
