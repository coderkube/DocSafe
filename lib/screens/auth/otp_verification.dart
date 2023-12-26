// import 'package:docsafe/config/color_file.dart';
// import 'package:docsafe/config/image_path.dart';
// import 'package:docsafe/config/text_style.dart';
// import 'package:docsafe/controllers/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';
//
// class OtpVerificationScreen extends StatelessWidget {
//   const OtpVerificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.k23242E,
//       body: GetBuilder(
//         init: Get.find<AuthController>(),
//         builder: (controller) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: size.height(20)),
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       size.heightSpace(43),
//                       SvgPicture.asset(AppImagePath.otpVerificationImg),
//                       size.heightSpace(50),
//                       Text(
//                         "OTP Verification",
//                         style: AppTextStyle.semiBoldLargeText,
//                       ),
//                       Text(
//                         "Please enter the 4 digit code sent\nto your email.",
//                         textAlign: TextAlign.center,
//                         style: AppTextStyle.normalRegularText
//                             .copyWith(fontSize: size.height(16)),
//                       ),
//                       size.heightSpace(30),
//                       Form(
//                         key: controller.otpFormKey,
//                         child: Pinput(
//                           length: 4,
//                           controller: controller.otpController,
//                           keyboardType: TextInputType.number,
//                           defaultPinTheme: PinTheme(
//                             width: size.height(50),
//                             height: size.height(50),
//                             textStyle: AppTextStyle.semiBoldMediumLargeText,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: AppColors.kFFFFFF),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                         text: "Didn’t receive the OTP?\t",
//                         style: AppTextStyle.normalSmallText,
//                         children: [
//                           TextSpan(
//                               text: "Resend OTP",
//                               style: AppTextStyle.semiBoldMediumText),
//                         ]),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
