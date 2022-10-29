import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appName'.tr),
      ),
      body: SafeArea(
          child: OverlappingPanels(
        leftWidget: Container(
          color: Colors.red,
        ),
        mainWidget: Container(
          color: Colors.green,
        ),
        rightWidget: Container(
          color: Colors.blue,
        ),
      )),
    );
  }
}
