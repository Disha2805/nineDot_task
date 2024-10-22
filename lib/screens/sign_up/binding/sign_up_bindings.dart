import 'package:get/get.dart';
import 'package:ninedot_task/screens/sign_up/controller/sign_up_controller.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(SignUpController());
  }
}
