import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/controllers/thread_controller.dart';

class AddThreadDialog extends StatelessWidget {
  AddThreadDialog({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('create thread'.tr),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'name of the new thread'.tr,
          suffixIcon: IconButton(
            onPressed: () => createThread(_controller.text).then((err) =>
                err == null ? Get.back() : Get.snackbar('error'.tr, err)),
            icon: const Icon(Icons.send),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('cancel'.tr),
        ),
      ],
    );
  }
}
