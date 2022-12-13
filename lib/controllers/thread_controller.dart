import 'package:get/get.dart';

import 'package:team_reminder_frontend/configs/constants.dart';

import 'package:team_reminder_frontend/controllers/data_load_mixin.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';

class ThreadController extends GetxController with DataLoadMixin {
  // null is main home
  final _currentThread = Rx<ThreadModel?>(null);

  ThreadModel? get currentThread => _currentThread.value;

  void changeThread(String threadId) {
    fetchAPI("$API_THREAD_BASE_URL/$threadId");
  }

  @override
  void setData(Map<String, dynamic> json) {
    _currentThread.value = ThreadModel.fromJson(json);
  }
}
