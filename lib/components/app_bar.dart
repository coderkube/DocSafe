import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget{
  const AppBarCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: AppColors.k23242E,
      iconTheme: const IconThemeData(color: AppColors.kF2F2F2),
      title: Text(
        "back".tr,
        style: AppTextStyle.semiBoldRegularText
            .copyWith(color: AppColors.kF2F2F2),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(size.height(35));
}
