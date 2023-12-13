import 'package:docsafe/screens/auth/check_mail_screen.dart';
import 'package:docsafe/screens/auth/create_password_screen.dart';
import 'package:docsafe/screens/auth/otp_verification.dart';
import 'package:docsafe/screens/auth/reset_password_screen.dart';
import 'package:docsafe/screens/auth/sign_in_screen.dart';
import 'package:docsafe/screens/auth/sign_up_screen.dart';
import 'package:docsafe/screens/auth/welcome_screen.dart';
import 'package:docsafe/screens/directory/my_space.dart';
import 'package:docsafe/screens/bottom_navi_bar.dart';
import 'package:docsafe/screens/directory/space_item.dart';
import 'package:docsafe/screens/home/dashboard_screen.dart';
import 'package:docsafe/screens/introduction_screen.dart';
import 'package:docsafe/screens/splash_screen.dart';
import 'package:get/get.dart';

appRouting() => [
      GetPage(name: "/", page: () => const SplashScreen()),
      GetPage(name: "/Welcome", page: () => const WelcomeScreen()),
      GetPage(name: "/SignIn", page: () => const SignInScreen()),
      GetPage(name: "/SignUp", page: () => const SignUpScreen()),
      GetPage(name: "/ResetPassword", page: () => const ResetPasswordScreen()),
      GetPage(name: "/CheckMail", page: () => const CheckMailScreen()),
      GetPage(name: "/OtpVerification", page: () => const OtpVerificationScreen()),
      GetPage(name: "/CreatePassword", page: () => const CreatePasswordScreen()),
      GetPage(name: "/OnBoarding", page: () => const OnBoardingScreen()),
      GetPage(name: "/HomeScreen", page: () => const DashBoardScreen()),
      GetPage(name: "/MySpace", page: () => const MySpaceScreen()),
      GetPage(name: "/BottomBar", page: () => const BottomNaviBar()),
      GetPage(name: "/SpaceItem", page: () => const SpaceItemScreen()),
    ];
