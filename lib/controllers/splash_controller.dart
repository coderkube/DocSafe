import 'package:docsafe/main.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if(localStorage.read('pin') != null){
          return Get.offNamed("/Pin");
        } else {
          return Get.offNamed("/OnBoarding");
        }
        // if (Supabase.instance.client.auth.currentSession?.user != null) {
        //   return Get.offNamed("/Pin");
        // } else {
        //   return Get.offNamed("/OnBoarding");
        // }
      },
    );
    super.onInit();
  }
}
