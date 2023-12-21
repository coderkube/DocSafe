import 'package:docsafe/config/color_file.dart';
import 'package:docsafe/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<SettingController>(),
      builder: (controller) {
        // final name = Supabase.instance.client.from('users').select('name');
        // kDebugPrint('name---> ${name.name}');
      return Scaffold(
        backgroundColor: AppColors.k23242E,
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: size.height(25)),
              margin: EdgeInsets.only(
                top: size.height(100),
                left: size.width(25),
                right: size.width(25)),
              decoration: const BoxDecoration(
                color: AppColors.k3D3D3D,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: size.height(70),
                    backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1618641986557-1ecd230959aa?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D'),
                  ),
                  size.heightSpace(10),
                  Text('Dharmik',
                    style: TextStyle(
                    fontSize: size.height(20),
                    color: AppColors.kFFFFFF,
                    fontWeight: FontWeight.w600)),
                  size.heightSpace(10),
                  Text('d@gmail.com',
                      style: TextStyle(
                          fontSize: size.height(20),
                          color: AppColors.kFFFFFF,
                          fontWeight: FontWeight.w600)),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.language, color: AppColors.k68D9A3,),
                    title: Text('Language', style: TextStyle(color: AppColors.kFFFFFF),)),
                  ListTile(
                      onTap: () {
                      },
                      leading: const Icon(Icons.fingerprint, color: AppColors.k68D9A3,),
                      title: const Text('Finger Print', style: TextStyle(color: AppColors.kFFFFFF),)),
                  ListTile(
                    onTap: () async {
                      await Supabase.instance.client.auth.signOut();
                      Get.offNamed("/SignIn");
                    },
                      leading: const Icon(Icons.logout, color: AppColors.k68D9A3,),
                      title: const Text('Sign Out', style: TextStyle(color: AppColors.kFFFFFF),)),
                ],
              ),
            )
          ],
        )
      );
    },);
  }
}
// Center(
// child: ElevatedButton(
// onPressed: () async {
// await Supabase.instance.client.auth.signOut();
// Get.offNamed("/SignIn");
// },
// child: const Text("Sign Out")),
// ),