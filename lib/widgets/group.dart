import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';
import 'package:team_reminder_frontend/models/thread_post_model.dart';

import 'package:team_reminder_frontend/controllers/user_controller.dart';
import 'package:team_reminder_frontend/controllers/group_controller.dart';

class GroupWidget extends StatelessWidget {
  GroupWidget({super.key});

  final currentUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<GroupController>(
        builder: (_) {
          developer.log('${_.myGroups}');

          return ListView(
            children: _.myGroups.entries.map(threadBuilder).toList(),
          );
        },
      ),
    );
  }
}

CircleAvatar threadBuilder(MapEntry<String, String> entry) {
  return CircleAvatar(
    backgroundColor: Colors.brown.shade800,
    child: FittedBox(fit: BoxFit.cover, child: Text(entry.value)),
  );
}
