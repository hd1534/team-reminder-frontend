import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import 'configs/translations.dart';

import 'controllers/app_controller.dart';

import 'package:team_reminder_frontend/configs/size_config.dart';

import 'package:team_reminder_frontend/views/home.dart';
import 'package:team_reminder_frontend/views/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
              iconTheme: const IconThemeData(color: Colors.black87)),
          translations: Messages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              SizeConfig.init(context);

              // loading
              if (snapshot.connectionState != ConnectionState.active) {
                return const Center(child: CircularProgressIndicator());
              }

              // logged in
              final user = snapshot.data;
              if (user != null) {
                Get.find<AppController>().initAfterLogin();

                return const HomeWidget();
              }

              // logged out
              return const LoginWidget();
            },
          ),
        );
      }
    });
  }
}
