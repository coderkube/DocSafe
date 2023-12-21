import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/main.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
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
  TextEditingController pinController = TextEditingController();
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
  String ROUTE_NAME = '/CreatePassword-callback';

  void signUpNewUser() async {
    isLoading = true;
    update();
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: signUpEmailController.text,
        password: signUpPasswordController.text,
      );
      await Supabase.instance.client.from("users").insert({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": signUpEmailController.text
      });
      localStorage.write('userid', response.user?.id);
      isLoading = false;
      update();
      Get.offNamed("/SignIn");
      Toast.successToast(message: "Register Successfully !!");
      firstNameController.clear();
      lastNameController.clear();
      signUpEmailController.clear();
      signUpPasswordController.clear();
      signUpConfirmPasswordController.clear();
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

  Future<void> signIn() async {
    isLoading = true;
    update();
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
          email: signInEmailController.text,
          password: signInPasswordController.text);

      Toast.successToast(message: "Login Successfully !!");
      signInEmailController.clear();
      signInPasswordController.clear();
      Get.offAllNamed("/PinSet");
    } catch (e) {
      isLoading = false;
      update();
      if (e is AuthException) {
        Toast.errorToast(message: e.message);
      } else {
        kDebugPrint("An error occurred: $e");
      }
    }
    isLoading = false;
    update();
  }

  void resetPasswordForEmail() async {
    isLoading = true;
    update();
    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
          resetPasswordController.text,
          redirectTo: "io.supabase.ekyjocxsvvedoxxwzllt://login-callback/").then((value) {
            Get.toNamed("/CreatePassword");
          });

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
