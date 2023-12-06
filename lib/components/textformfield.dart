import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';

class TextFormFieldCommon extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? obscuringCharacter;
  final TextInputType? keyboardType;
  final String? Function(dynamic value)? validator;

  const TextFormFieldCommon({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter,
    this.keyboardType, this.validator,
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
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
            vertical: size.height(13), horizontal: size.width(10)),
        hintStyle: AppTextStyle.normalRegularText
            .copyWith(fontSize: size.height(16)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
