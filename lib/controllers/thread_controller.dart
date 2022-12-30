import 'dart:async';

import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:team_reminder_frontend/configs/constants.dart';

import 'package:team_reminder_frontend/controllers/group_controller.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';

class ThreadController extends GetxController {
  // null is main home
  final _currentThread = Rx<ThreadModel?>(null);
  ThreadModel? get currentThread => _currentThread.value;
  StreamSubscription<DatabaseEvent>? _curThreadSub;

  void listeningCurrentThread(String threadId) {
    var curGroupId = Get.find<GroupController>().currentGroup?.id;

    if (curGroupId == null) return;

    _curThreadSub?.cancel();

    var curThreadRef =
        FirebaseDatabase.instance.ref('groups/$curGroupId/threads/$threadId');
    _curThreadSub = curThreadRef.onValue.listen((event) {
      if (event.snapshot.value == null) return;

      var data = Map<String, dynamic>.from(event.snapshot.value as Map);

      _currentThread.value = ThreadModel.fromJson({'id': threadId, ...data});
    });
  }
}

Future<String?> createThread(String threadName) async {
  var curGroupId = Get.find<GroupController>().currentGroup?.id;

  if (curGroupId == null) return 'group not founded'.tr;

  var threadKey = FirebaseDatabase.instance
      .ref('groups/$curGroupId')
      .child('threads')
      .push()
      .key;

  await FirebaseDatabase.instance.ref('groups/$curGroupId/threads').update({
    threadKey!: {
      'name': threadName,
      'contents': '',
      'createdDate': DateTime.now().millisecondsSinceEpoch,
    },
  });

  Get.find<ThreadController>().listeningCurrentThread(threadKey!);
  return null;
}

Future<String?> updateThread(String contents) async {
  var curGroupId = Get.find<GroupController>().currentGroup?.id;
  if (curGroupId == null) return 'group not founded'.tr;

  var curThreadId = Get.find<ThreadController>().currentThread?.id;
  if (curThreadId == null) return 'thread not founded'.tr;

  await FirebaseDatabase.instance
      .ref('groups/$curGroupId/threads/$curThreadId')
      .update({'contents': contents});

  return null;
}
