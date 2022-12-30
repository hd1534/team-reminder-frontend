import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/utils.dart';

import 'package:team_reminder_frontend/configs/size_config.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(48, 48, 48, 0.8),
        child: ListView(
          children: [
            _header(),
            _logOut(),
            const Divider(color: Colors.white),
            _invitation(),
            _teamMembers(),
          ],
        ));
  }

  OutlinedButton _invitation() {
    return OutlinedButton(
      child: Text('invite member'.tr),
      onPressed: () {},
    );
  }

  Container _teamMembers() {
    return Container();
  }

  Container _header() {
    Widget? _child;
    if (FirebaseAuth.instance.currentUser != null) {
      _child = Container(
          padding: EdgeInsets.only(
              left: SizeConfig.defaultSize * 1.7,
              bottom: SizeConfig.defaultSize * 1),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "${FirebaseAuth.instance.currentUser?.photoURL}"),
              radius: SizeConfig.defaultSize * 3,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.defaultSize * 1.5,
                  bottom: SizeConfig.defaultSize * 1.5),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${FirebaseAuth.instance.currentUser?.displayName}",
                      style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 2,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                    ),
                    Text(
                      "${FirebaseAuth.instance.currentUser?.email}",
                      style: TextStyle(
                          fontSize: SizeConfig.defaultSize * 1.5,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                    ),
                  ]),
            ),
          ]));
    }

    return Container(
      height: SizeConfig.defaultSize * 10,
      child: _child,
    );
  }

  Container _logOut() {
    Widget _child;
    _child = OutlinedButton(
      child: Text("logout".tr),
      onPressed: () => FirebaseAuth.instance.signOut(),
    );

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.defaultSize * 3,
          horizontal: SizeConfig.defaultSize * 6),
      child: _child,
    );
  }
}
