import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/controllers/email_verification_controller.dart';
import 'package:task_manager/ui/controllers/in_progress_task_controller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/pin_verification_controller.dart';
import 'package:task_manager/ui/controllers/reset_password_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controllers.dart';
import 'package:task_manager/ui/controllers/sign_up_controller.dart';
import 'package:task_manager/ui/controllers/task_item_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SignInControllers());
    Get.lazyPut(()=>NewTaskController());
    Get.lazyPut(()=>AuthControllers());
    Get.lazyPut(()=>NetworkCaller());
    Get.lazyPut(()=>EmailVerificationController());
    Get.lazyPut(()=>AddNewTaskController());
    Get.lazyPut(()=>UpdateProfileController());
    Get.lazyPut(()=>SignUpController());
    Get.lazyPut(()=>ResetPasswordController());
    Get.lazyPut(()=>PinVerificationController());
    Get.lazyPut(()=>CancelledTaskController());
    Get.lazyPut(()=>CompletedTaskController());
    Get.lazyPut(()=>InProgressTaskController());
    Get.lazyPut(()=>TaskItemController());
  }

}