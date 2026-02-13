import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/auth_controllers.dart';

class UpdateProfileController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  AuthControllers authControllers = Get.find<AuthControllers>();
  bool _updateProfileInProgress = false;
  String _errorMessage = '';
  XFile? _selectedImage;

  bool get updateProfileInProgress => _updateProfileInProgress;
  String get errorMessage => _errorMessage;
  XFile? get selectedImage => _selectedImage;

  Future<void> pickProfileImage() async {
    final imagePicker = ImagePicker();
    final XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
    if(result!=null){
      _selectedImage = result;
      update();
    }

  }

  Future<bool> updateProfile(String email, String firstName, String lastName, String mobile, String password) async {
    bool isSuccess = false;
    _updateProfileInProgress = true;
    String encodePhoto = authControllers.userData?.photo?? '';
    update();
    Map<String,dynamic> requestBody = {
      "email" : email,
      "firstName" : firstName,
      "lastName" : lastName,
      "mobile" : mobile,
    };

    if(password.isNotEmpty){
      requestBody['password'] = password;
    }
    if(_selectedImage!=null){
      File file = File(_selectedImage!.path);
      encodePhoto = base64Encode(file.readAsBytesSync());
      requestBody['photo'] = encodePhoto;
    }

    NetworkResponse response = await networkCaller.postRequest(Urls.profileUpdate,body: requestBody);

    if(response.isSuccess && response.responseData['status'] == 'success'){
      UserModel userModel = UserModel(
        email: email,
        photo: encodePhoto,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
      );
      await authControllers.saveUserData(userModel);
      update();
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage?? 'Profile Update Failed!';
    }
    _updateProfileInProgress = false;
    update();
    return isSuccess;






  }
}