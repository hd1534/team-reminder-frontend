import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';
import 'package:team_reminder_frontend/models/thread_post_model.dart';

import 'package:team_reminder_frontend/controllers/user_controller.dart';
import 'package:team_reminder_frontend/controllers/group_controller.dart';

import 'package:team_reminder_frontend/widgets/add_group.dart';

class GroupWidget extends StatelessWidget {
  GroupWidget({super.key});

  final currentUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<GroupController>(
        builder: (_) {
          final myGroups = _.myGroups.entries.map(threadBuilder).toList();

          return ListView(
            children: myGroups + [addGroup()],
          );
        },
      ),
    );
  }
}

Widget threadBuilder(MapEntry<String, String> entry) {
  return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: const Color.fromRGBO(148, 148, 148, 0.5),
        child: FittedBox(fit: BoxFit.cover, child: Text(entry.value)),
      ));
}

Widget addGroup() {
  return ElevatedButton(
    onPressed: () => Get.dialog(AddGroupDialog()),
    child: Icon(Icons.add, color: Colors.white),
    style: ElevatedButton.styleFrom(
      shape: CircleBorder(),
      padding: EdgeInsets.all(10),
      backgroundColor:
          const Color.fromRGBO(148, 148, 148, 0.5), // <-- Button color
      foregroundColor: Colors.red, // <-- Splash color
    ),
  );
}
