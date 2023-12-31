import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';

class TextFormFieldCommon extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLength;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(dynamic value)? validator;

  const TextFormFieldCommon({
    super.key,
    this.labelText,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    this.obscureText = false,
    this.obscuringCharacter,
    this.keyboardType, this.validator, this.maxLength, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyle.normalRegularText,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter ?? "*",
      keyboardType: keyboardType,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(
            vertical: size.height(13), horizontal: size.width(10)),
        hintStyle: AppTextStyle.normalRegularText.copyWith(color: AppColors.k707070),
        labelStyle: AppTextStyle.normalRegularText
            .copyWith(fontSize: size.height(16)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
