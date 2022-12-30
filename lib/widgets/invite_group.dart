import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:clipboard/clipboard.dart';

import 'package:team_reminder_frontend/controllers/group_controller.dart';

class InviteGroupDialog extends StatelessWidget {
  InviteGroupDialog({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inviteCode = '${Get.find<GroupController>().currentGroup?.id}';

    return AlertDialog(
      title: Text('sharing invite code'.tr),
      content: Row(children: [
        SelectableText(
          inviteCode,
        ),
        IconButton(
            onPressed: () => FlutterClipboard.copy(inviteCode),
            icon: const Icon(
              Icons.copy,
              color: Colors.white,
            ))
      ]),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('cancel'.tr),
        ),
      ],
    );
  }
}
