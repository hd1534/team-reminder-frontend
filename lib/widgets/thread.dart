import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/configs/size_config.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';
import 'package:team_reminder_frontend/models/thread_post_model.dart';

import 'package:team_reminder_frontend/controllers/user_controller.dart';
import 'package:team_reminder_frontend/controllers/group_controller.dart';
import 'package:team_reminder_frontend/controllers/thread_controller.dart';

import 'package:team_reminder_frontend/widgets/add_thread.dart';

class ThreadWidget extends StatelessWidget {
  ThreadWidget({super.key});

  final currentUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<GroupController>(
        builder: (_) {
          if (_.currentGroup == null) {
            return Container(
                padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
                alignment: Alignment.topCenter,
                child: Text(
                  'Select the group first.'.tr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: SizeConfig.defaultSize * 2),
                ));
          }

          // thread
          final myGroups =
              _.currentGroup?.threads.map(threadBuilder).toList() ?? [];

          return ListView(
            children: myGroups + [addGroup()],
          );
        },
      ),
    );
  }
}

Widget threadBuilder(ThreadModel thread) {
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    child: OutlinedButton(
      onPressed: () =>
          Get.find<ThreadController>().listeningCurrentThread(thread.id),
      // Get.find<ThreadController>().listeningCurrentGroup(entry.key),
      child: FittedBox(fit: BoxFit.cover, child: Text(thread.name)),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(20),
        foregroundColor: Colors.white, // <-- Splash color
      ),
    ),
  );
}

Widget addGroup() {
  return OutlinedButton(
    onPressed: () => Get.dialog(AddThreadDialog()),
    child: Text('create thread'.tr),
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.all(20),
      foregroundColor: Colors.white, // <-- Splash color
    ),
  );
}
