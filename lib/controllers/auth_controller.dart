import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController signInEmailController = TextEditingController();
  final TextEditingController signInPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool visiblePassword = true;
  bool confirmVisiblePassword = true;

  String emailValidationRegExp = r'\S+@\S+\.\S+';

  void signUpNewUser() async {
    final response = await Supabase.instance.client.auth
        .signUp(email: emailController.text, password: passwordController.text);
    await Supabase.instance.client.from("users").insert({
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text
    });
  }

  Future<void> signIn() async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
        email: signInEmailController.text,
        password: signInPasswordController.text);
    // print("response--->${response.user.}")
  }
}
