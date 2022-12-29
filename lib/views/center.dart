import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/widgets/post.dart';
import 'package:team_reminder_frontend/widgets/text_input.dart';

class CenterView extends StatelessWidget {
  const CenterView({super.key});

  @override
  Widget build(BuildContext context) {
    final overPanelCtrl = Get.find<OverlappingPanelsController>();

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => overPanelCtrl.revealSide(Side.left),
            ),
            title: Text('appName'.tr),
            actions: [
              IconButton(
                icon: const Icon(Icons.group),
                onPressed: () => overPanelCtrl.revealSide(Side.right),
              )
            ],
          ),
          body: Stack(
            children: [
              PostWidget(),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: TextInputWidget(),
              ),
            ],
          ),
        ));
  }
}
