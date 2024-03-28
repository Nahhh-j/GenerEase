import 'package:generease/app/controller/page_controller.dart';
import 'package:get/get.dart';

class BaseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppPageController());
  }
}
