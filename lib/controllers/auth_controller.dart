import 'package:docsafe/config/color_file.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';
import '../utils/toast.dart';

class AuthController extends GetxController {

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> otpFormKey = GlobalKey();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey();

  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();
  final TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();

  bool signUpVisiblePassword = true;
  bool signInVisiblePassword = true;
  bool createVisiblePassword = true;
  bool signUpConfirmVisiblePassword = true;
  bool createConfirmVisiblePassword = true;
  bool isLoading = false;

  String emailValidationRegExp = r'\S+@\S+\.\S+';
  String userId = "";
  String resetToken = "";

  void signUpNewUser() async {
    isLoading = true;
    update();
    try {
      final response = await Supabase.instance.client.auth.signUp(
          email: signUpEmailController.text,
          password: signUpPasswordController.text,
          data: {
            "first_name": firstNameController.text,
            "last_name": lastNameController.text
          });
      isLoading = false;
      update();
      Get.offNamed("/SignIn");
      Toast.successToast(message: "Register Successfully !!");
    } catch (e) {
      isLoading = false;
      update();
      if (e is AuthException) {
        Toast.errorToast(message: e.message);
      } else {
        kDebugPrint("An error occurred: $e");
      }
    }
  }

  void signIn() async {
    isLoading = true;
    update();
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
          email: signInEmailController.text,
          password: signInPasswordController.text);
      isLoading = false;
      update();
      Get.offNamed("/HomeScreen");
      Toast.successToast(message: "Login Successfully !!");
    } catch (e) {
      isLoading = false;
      update();
      if (e is AuthException) {
        Toast.errorToast(message: e.message);
      } else {
        kDebugPrint("An error occurred: $e");
      }
    }
  }

  void resetPasswordForEmail() async {
    isLoading = true;
    update();
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        resetPasswordController.text,
        redirectTo: "io.supabase.ekyjocxsvvedoxxwzllt://login-callback/"
      );
      isLoading = false;
      update();
      Toast.successToast(message: "OTP Sent Successfully");
      // Get.toNamed("/CheckMail");
    } catch (e) {
      isLoading = false;
      update();
      if (e is AuthException) {
        Toast.errorToast(message: e.message);
      }
      kDebugPrint("----> Throw Exception --> $e");
    }
  }

  void initUniLinks() async {
    try {
      String? initialLink = await getInitialLink();
      handleLink(initialLink!);
      kDebugPrint("initialLink......$initialLink");
    } catch (e) {
      kDebugPrint("initUniLinks Catch Error ----> $e");
    }

    linkStream.listen(handleLink);
  }

  void handleLink(String? link) {
    // Check if link is not null before processing
    if (link != null) {
      // Extract userId and resetToken from the link
      // The link might look like: io.supabase.ekyjocxsvvedoxxwzllt://login-callback/?userId=123&token=xyz
      Uri uri = Uri.parse(link);
        userId = uri.queryParameters["userId"] ?? "";
        resetToken = uri.queryParameters["token"] ?? "";
      update();
      kDebugPrint("User ID----> $userId");
      kDebugPrint("resetToken----> $resetToken");
      // Navigate to the password change screen
      if (userId.isNotEmpty && resetToken.isNotEmpty) {
        Get.offNamed("/ResetPassword");
      }
    }
  }


  @override
  void onInit() {
    initUniLinks();
    super.onInit();
  }
}
// try {
//   final response = await Supabase.instance.client.auth
//       .signUp(signUpEmailController.text, signUpPasswordController.text);
//   kDebugPrint("error---====> ${response.error?.message}");
//   if (response.error == null) {
//     Supabase.instance.client.from('users').insert({
//       'first_name': firstNameController.text,
//       'last_name': lastNameController.text,
//       'email': signUpEmailController.text
//     });
//     isLoading = false;
//     update();
//     Get.offNamed("/SignIn");
//     Toast.successToast(message: "Register Successfully !!");
//   } else {
//     isLoading = false;
//     update();
//     // Toast.errorToast(message: response.error?.message);
//     // kDebugPrint("error aaa---====> ${response.error?.message}");
//     kDebugPrint("----------> Something went wrong");
//   }
// } catch (error) {
//   isLoading = false;
//   update();
//   kDebugPrint("Error------> $error");
// }

// try {
//   final response = await Supabase.instance.client.auth.signIn(
//       email: signInEmailController.text,
//       password: signInPasswordController.text);
//   kDebugPrint("error---====> ${response.error?.message}");
//   if (response.error == null) {
//     isLoading = false;
//     update();
//     // Get.offNamed("/HomeScreen");
//     Toast.successToast(message: "Login Successfully !!");
//   } else {
//     isLoading = false;
//     update();
//     Toast.errorToast(message: response.error?.message);
//     kDebugPrint("error aaa---====> ${response.error?.message}");
//   }
// } catch (error) {
//   isLoading = false;
//   update();
//   kDebugPrint("Catch Error------> $error");
// }
