import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/utils.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    dev.log('${FirebaseAuth.instance.currentUser}');

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text('logout'.tr),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
          Text('data'),
        ],
      ),
    );
  }
}
