import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/models/thread_post_model.dart';

import 'package:team_reminder_frontend/controllers/thread_controller.dart';

class Thread extends StatelessWidget {
  const Thread({super.key});

  @override
  Widget build(BuildContext context) {
    final overPanelCtrl = Get.find<OverlappingPanelsController>();

    return Scaffold(
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
      body: GetX<ThreadController>(
        builder: (_) {
          return ListView(
            children: _.currentThread?.posts?.map(postBuilder).toList() ?? [],
          );
        },
      ),
    );
  }
}

Container postBuilder(PostItem post) {
  developer.log('$post');

  return Container(
    margin: EdgeInsets.all(50.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: const Color.fromARGB(47, 100, 100, 100),
    ),
    child: Column(
      children: [
        Text('${post.title}'),
        Text('${post.contexts}'),
      ],
    ),
  );
}
