import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';
import 'package:team_reminder_frontend/models/thread_post_model.dart';

import 'package:team_reminder_frontend/controllers/group_controller.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<GroupController>(
        builder: (_) {
          return ListView(
            children: _.currentGroup?.threads.entries
                    .map<CircleAvatar>(threadBuilder)
                    .toList() ??
                [],
          );
        },
      ),
    );
  }
}

CircleAvatar threadBuilder(MapEntry<String, ThreadModel> entry) {
  return CircleAvatar(
    backgroundColor: Colors.brown.shade800,
    child: FittedBox(fit: BoxFit.cover, child: Text('${entry.value.name}')),
  );
}
