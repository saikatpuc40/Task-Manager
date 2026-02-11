import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class AddNewTaskController extends GetxController{

  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _addNewTaskInProgress = false;
  String _errorMessage = '';

  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title, String description) async {

    bool isSuccess = false;
    _addNewTaskInProgress = true;
    update();
    Map<String,dynamic> requestData={
      "title" : title,
      "description" : description,
      "status" : "New"
    };

    NetworkResponse response = await networkCaller.postRequest(Urls.createTask,body: requestData);
    if(response.isSuccess){
      isSuccess =true;
    }
    else{
      _errorMessage = response.errorMessage?? "Task Added Failed!.Try Again.";
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;

  }
}