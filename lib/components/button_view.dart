import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';

class ButtonViewCommon extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const ButtonViewCommon({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: size.height(17)),
        decoration: BoxDecoration(
            color: AppColors.k6167DE, borderRadius: BorderRadius.circular(8)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyle.semiBoldRegularText
              .copyWith(color: AppColors.kFFFFFF),
        ),
      ),
    );
  }
}
