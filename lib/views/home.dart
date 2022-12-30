import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/views/group_thread.dart';
import 'package:team_reminder_frontend/views/center.dart';
import 'package:team_reminder_frontend/views/users.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const OverlappingPanels(
      leftWidget: Groupthread(),
      mainWidget: CenterView(),
      rightWidget: UsersWidget(),
    );
  }
}
