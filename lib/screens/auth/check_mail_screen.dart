// import 'package:docsafe/config/color_file.dart';
// import 'package:docsafe/config/image_path.dart';
// import 'package:docsafe/config/text_style.dart';
// import 'package:docsafe/controllers/auth_controller.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CheckMailScreen extends StatelessWidget {
//   const CheckMailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(seconds: 3), () => Get.offNamed("/OtpVerification"),);
//     return Scaffold(
//       backgroundColor: AppColors.k23242E,
//       body: GetBuilder(
//         init: Get.find<AuthController>(),
//         builder: (controller) {
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       height: size.height(134),
//                       width: size.width(139),
//                       child: Image.asset(AppImagePath.checkMailImg)),
//                   size.heightSpace(15),
//                   Text(
//                     "Check Your Mail",
//                     style: AppTextStyle.semiBoldLargeText,
//                   ),
//                   Text(
//                     "We have sent a password recover\nverification to your email.",
//                     textAlign: TextAlign.center,
//                     style: AppTextStyle.normalRegularText
//                         .copyWith(fontSize: size.height(16)),
//                   ),
//                 ],
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                           text:
//                               "Did not receive the email? Check your spam filter,\nor\t",
//                           style: AppTextStyle.normalSmallText,
//                           children: [
//                             TextSpan(
//                               recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed("/ResetPassword"),
//                                 text: "try another email address",
//                                 style: AppTextStyle.semiBoldMediumText),
//                           ]),
//                     ),
//                     size.heightSpace(29)
//                   ],
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
