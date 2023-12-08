import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.k23242E,
      appBar: AppBar(
        backgroundColor: AppColors.k23242E,
        title: RichText(
            text: TextSpan(
                text: "hello,\t".tr,
                style: AppTextStyle.semiBoldLargeText
                    .copyWith(fontSize: size.height(22)),
                children: [
              TextSpan(
                  text: "Admin !",
                  style: AppTextStyle.semiBoldLargeText
                      .copyWith(color: AppColors.k6167DE))
            ])),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height(26), horizontal: size.width(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // Text("Card", style: AppTextStyle,)
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  Get.offNamed("/SignIn");
                },
                child: const Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
