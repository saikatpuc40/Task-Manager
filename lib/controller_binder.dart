import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
import 'package:task_manager/ui/controllers/email_verification_controller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controllers.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SignInControllers());
    Get.lazyPut(()=>NewTaskController());
    Get.lazyPut(()=>AuthControllers());
    Get.lazyPut(()=>NetworkCaller());
    Get.lazyPut(()=>EmailVerificationController());
    Get.lazyPut(()=>AddNewTaskController());
  }

}