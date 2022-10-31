import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () =>
              Get.find<OverlappingPanesController>().revealSide(Side.left),
        ),
        title: Text('appName'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () =>
                Get.find<OverlappingPanesController>().revealSide(Side.right),
          )
        ],
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
        onSideChange: (value) => developer.log("change to $value"),
        afterSideChanged: (value) => developer.log("$value revealed"),
      )),
    );
  }
}
