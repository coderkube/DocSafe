import 'package:docsafe/config/color_file.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
      kDebugPrint("Response--> ${response.session?.accessToken}");
      kDebugPrint("Response--> ${response.user?.id}");
      // kDebugPrint("Response--> ${response.user?.}");
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
