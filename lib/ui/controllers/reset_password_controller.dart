import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class ResetPasswordController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _resetPasswordScreenInProgress = false;
  String _errorMessage = '';


  bool get resetPasswordScreenInProgress => _resetPasswordScreenInProgress;
  String get errorMessage => _errorMessage;


  Future<bool> resetPassword(String email,String otp,String password) async {
    bool isSuccess = false;
    _resetPasswordScreenInProgress = true;
    update();
    Map<String, dynamic> requestInput = {
      "email": email,
      "OTP":otp,
      "password":password,

    };
    NetworkResponse response =
    await networkCaller.postRequest(Urls.registration, body: requestInput);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Password Reset Failed! Try Again.';
    }
    _resetPasswordScreenInProgress = false;
    update();
    return isSuccess;
    }
  }
