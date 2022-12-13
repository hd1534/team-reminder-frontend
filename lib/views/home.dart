import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:team_reminder_frontend/views/thread.dart';
import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlappingPanels(
      leftWidget: Container(
        color: Colors.red,
      ),
      mainWidget: const Thread(),
      rightWidget: Container(
        color: Colors.blue,
      ),
    );
  }
}
