import 'package:docsafe/config/localization.dart';
import 'package:docsafe/config/root_binding.dart';
import 'package:docsafe/config/supabase_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/routing.dart';

final localStorage = GetStorage();
String languageCode = localStorage.read('languageCode') ?? 'en';
String countryCode = localStorage.read('countryCode') ?? 'US';

void main() async {
  await Supabase.initialize(
      url: SupaBaseManager.supabaseUrl,
      anonKey: SupaBaseManager.supabaseAnonKey);
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
  disableCapture();
}

disableCapture() async {
  await ScreenProtector.protectDataLeakageOn();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        initialBinding: RootBinding(),
        translations: Localization(),
        locale: Locale(languageCode, countryCode),
        debugShowCheckedModeBanner: false,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(fontFamily: "Barlow"),
        initialRoute: "/",
        getPages: appRouting(),
      ),
    );
  }
}
