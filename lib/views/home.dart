import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/widgets/group.dart';
import 'package:team_reminder_frontend/widgets/post.dart';

import 'package:team_reminder_frontend/views/center.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlappingPanels(
      leftWidget: const GroupWidget(),
      mainWidget: const CenterView(),
      rightWidget: Container(
        color: Colors.blue,
      ),
    );
  }
}
