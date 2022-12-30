import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:get/utils.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:team_reminder_frontend/utils/auth/google.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login'.tr)),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SignInButton(
                Buttons.Google,
                onPressed: () => signInWithGoogle(),
              )
            ],
          )),
    );
  }
}
