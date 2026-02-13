import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class SignUpController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _registrationInProgress = false;
  String _errorMessage = '';

  bool get registrationInProgress => _registrationInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> registerUser(String email, String firstName, String lastName, String mobile, String password) async {
    bool isSuccess = false;
    _registrationInProgress = true;
    update();
    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };
    NetworkResponse response = await networkCaller.postRequest(Urls.registration, body: requestInput);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
       _errorMessage = response.errorMessage ?? 'Registration Failed! Try Again.';
    }
    _registrationInProgress = false;
    update();
    return isSuccess;
    }
  }
