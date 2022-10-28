import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'configs/translations.dart';

import 'init.dart';

import 'views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppController c = Get.put(AppController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!c.isInitialized.value) {
        return Center(child: CircularProgressIndicator());
      } else if (c.exception != null) {
        // handle exception
        return Center(child: Text('error'.tr));
      } else {
        return GetMaterialApp(
            translations: Messages(),
            locale: Get.deviceLocale,
            fallbackLocale: Locale('en', 'US'),
            home: Home());
      }
    });
  }
}
