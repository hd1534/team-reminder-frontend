import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simple_markdown_editor/simple_markdown_editor.dart';

import 'package:team_reminder_frontend/utils/getx/views/overlapping_panels.dart';

import 'package:team_reminder_frontend/controllers/group_controller.dart';
import 'package:team_reminder_frontend/controllers/thread_controller.dart';

import 'package:team_reminder_frontend/widgets/text_input.dart';

class CenterView extends StatefulWidget {
  const CenterView({super.key});

  @override
  State<CenterView> createState() => _CenterViewState();
}

class _CenterViewState extends State<CenterView> {
  bool _edit = false;
  late TextEditingController _controller;

  final threadCtrl = Get.find<ThreadController>();
  final overPanelCtrl = Get.find<OverlappingPanelsController>();

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: threadCtrl.currentThread?.contents);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => overPanelCtrl.revealSide(Side.left),
            ),
            title: Obx(() {
              final curGroup = Get.find<GroupController>().currentGroup;
              final curThread = Get.find<ThreadController>().currentThread;

              if (curGroup == null && curThread == null) {
                return Text('appName'.tr);
              }

              return Text('${curGroup?.name ?? ""}/${curThread?.name ?? ""}');
            }),
            actions: [
              _edit
                  ? IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        updateThread(_controller.text).then((err) {
                          if (err == null) return setState(() => _edit = false);

                          Get.snackbar('error'.tr, err);
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => setState(() => _edit = true),
                    ),
              IconButton(
                icon: const Icon(Icons.group),
                onPressed: () => overPanelCtrl.revealSide(Side.right),
              )
            ],
          ),
          body: Obx(() {
            _controller =
                TextEditingController(text: threadCtrl.currentThread?.contents);
            return SafeArea(
                child: _edit ? editorWidget() : makrdownViewWidget());
          }),
        ));
  }

  MarkdownFormField editorWidget() {
    return MarkdownFormField(
      controller: _controller,
      enableToolBar: true,
      emojiConvert: true,
      autoCloseAfterSelectEmoji: false,
    );
  }

  MarkdownParse makrdownViewWidget() {
    return MarkdownParse(
      data: _controller.text,
      onTapHastag: (String name, String match) {
        // name => hashtag
        // match => #hashtag
      },
      onTapMention: (String name, String match) {
        // name => mention
        // match => #mention
      },
    );
  }
}
