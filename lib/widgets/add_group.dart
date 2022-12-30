import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/controllers/group_controller.dart';

class AddGroupDialog extends StatelessWidget {
  AddGroupDialog({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('add group'.tr),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'type the invitation code'.tr,
          suffixIcon: IconButton(
            onPressed: () => participateGroup(_controller.text).then((err) =>
                err == null ? Get.back() : Get.snackbar('error'.tr, err)),
            icon: const Icon(Icons.send),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('create new'.tr),
        ),
      ],
    );
  }
}
