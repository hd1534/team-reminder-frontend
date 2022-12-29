import 'package:get/get.dart';

import 'package:team_reminder_frontend/controllers/group_controller.dart';
import 'package:team_reminder_frontend/controllers/thread_controller.dart';

class AppController extends GetxService {
  Exception? _exception;
  get exception => _exception;

  final _isInitialized = false.obs;
  get isInitialized => _isInitialized;

  Future<void> initialize() async {
    try {
      // init process
      await Future.delayed(const Duration(seconds: 1)); // TODO: remove

      await initGetxController();
    } on Exception catch (e) {
      _exception = e;
    } finally {
      _isInitialized.value = true;
    }
  }

  Future<void> initGetxController() async {
    Get.put(GroupController());
    Get.put(ThreadController());

    Get.find<GroupController>().changeGroup('test'); // TODO: remove tmp code
    Get.find<ThreadController>().changeThread('test'); // TODO: remove tmp code
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  @override
  void onClose() {
    _exception = null;
    _isInitialized.value = false;
    super.onClose();
  }
}
