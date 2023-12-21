import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpButtonCommon extends StatelessWidget {
  final void Function(String)? onSelected;
  final void Function()? deleteOnTap;
  final void Function()? pinOnTap;
  final void Function()? editOnTap;
  final String? pinText;

  const PopUpButtonCommon(
      {super.key, this.onSelected, this.deleteOnTap, this.pinOnTap, this.pinText, this.editOnTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(highlightColor: AppColors.kBlack38, fontFamily: "Barlow"),
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.more_vert_rounded,
            size: 24, color: AppColors.kFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.k111111,
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: editOnTap,
                value: 'Rename',
                child: Text(
                  'edit'.tr,
                  style: AppTextStyle.boldRegularText
                      .copyWith(fontWeight: FontWeight.w500),
                )),
            PopupMenuItem(
                onTap: pinOnTap,
                value: "Pin",
                child: Text(
                  pinText ?? 'pin'.tr,
                  style: AppTextStyle.boldRegularText
                      .copyWith(fontWeight: FontWeight.w500),
                )),
            PopupMenuItem(
                value: "Delete",
                onTap: deleteOnTap,
                child: Text(
                  'delete'.tr,
                  style: AppTextStyle.boldRegularText
                      .copyWith(fontWeight: FontWeight.w500),
                )),
          ];
        },
      ),
    );
  }
}
