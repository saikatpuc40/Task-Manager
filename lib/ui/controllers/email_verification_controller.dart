import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class EmailVerificationController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _emailVerificationScreenInProgress = false;
  String _errorMessage = '';

  bool get emailVerificationScreenInProgress => _emailVerificationScreenInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> emailVerification(String email) async {

    bool isSuccess = false;
    _emailVerificationScreenInProgress = true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.emailVerificationTask(email));
    if(response.isSuccess){
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage?? 'Email Verification Failed!';
    }
    _emailVerificationScreenInProgress = false;
    update();
    return isSuccess;


  }
}