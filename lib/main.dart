import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'configs/translations.dart';

import 'controllers/app_controller.dart';

import 'views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final c = Get.put(AppController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!c.isInitialized.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (c.exception != null) {
        // handle exception
        return Center(child: Text('error'.tr));
      } else {
        return GetMaterialApp(
            theme: ThemeData(
                brightness: Brightness.dark,
                iconTheme: IconThemeData(color: Colors.black87)),
            translations: Messages(),
            locale: Get.deviceLocale,
            fallbackLocale: const Locale('en', 'US'),
            home: const Home());
      }
    });
  }
}
