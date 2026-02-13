import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class PinVerificationController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _pinVerificationScreenInProgress = false;
  String _errorMessage = '';

  bool get pinVerificationScreenInProgress => _pinVerificationScreenInProgress;
  String get errorMessage => _errorMessage;



  Future<bool> emailVerification(String email,String pin) async {
    bool isSuccess =false;
    _pinVerificationScreenInProgress = true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.verifyPinTask(email,pin));
    if(response.isSuccess){
      isSuccess = true;
    }
    else{
       _errorMessage = response.errorMessage?? 'Pin Verification Failed!';
    }
    _pinVerificationScreenInProgress = false;
    update();
    return isSuccess;
  }

}