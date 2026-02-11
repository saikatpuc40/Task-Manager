import 'package:get/get.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';

class SignInControllers extends GetxController {
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  AuthControllers authControllers = Get.find<AuthControllers>();

  bool _signInApiInProgress = false;
  String _errorMessage = '';

  bool get signInApiInProgress => _signInApiInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _signInApiInProgress = true;
    update();
    Map<String, dynamic> requestData = {"email": email, "password": password};

    final NetworkResponse response = await networkCaller.postRequest(
      Urls.login,
      body: requestData,
    );

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);
      await authControllers.saveUserAccessToken(loginModel.token!);
      await authControllers.saveUserData(loginModel.userModel!);

      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? 'Login In Failed! Try Again.';
    }
    _signInApiInProgress = false;
    update();

    return isSuccess;
  }
}
