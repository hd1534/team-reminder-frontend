import 'package:get/get.dart';

class AppController extends GetxService {
  Exception? _exception;
  get exception => _exception;

  final _isInitialized = false.obs;
  get isInitialized => _isInitialized;

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

  Future<void> initialize() async {
    try {
      // init process
      await Future.delayed(Duration(seconds: 1)); // TODO: remove
    } on Exception catch (e) {
      _exception = e;
    } finally {
      _isInitialized.value = true;
    }
  }
}
