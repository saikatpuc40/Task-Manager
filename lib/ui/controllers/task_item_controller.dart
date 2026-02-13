import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class TaskItemController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _deleteTaskInProgress =false;
  String _errorMessageForDeleteTask = '';
  String get errorMessageForDeleteTask => _errorMessageForDeleteTask;
  bool get deleteTaskInProgress => _deleteTaskInProgress;



  bool _updateTaskInProgress =false;
  String _errorMessageForUpdateTask = '';
  String get errorMessageForUpdateTask => _errorMessageForUpdateTask;
  bool get updateTaskInProgress => _updateTaskInProgress;




  Future<bool> deleteTask(String taskId) async {
    bool isSuccess = false;
    _deleteTaskInProgress =true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.deleteTask(taskId));
    if(response.isSuccess){
      isSuccess = true;
    }
    else{
     _errorMessageForDeleteTask = response.errorMessage?? 'Task Delete Failed!';
    }
    _deleteTaskInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> updateTask(String taskId, String status) async {
    bool isSuccess = false;
    _updateTaskInProgress =true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.updateTask(taskId, status));
    if(response.isSuccess){
      isSuccess = true;
    }
    else{
      _errorMessageForUpdateTask =  response.errorMessage?? 'Task Completed Failed!';
      }
    _updateTaskInProgress = false;
    update();
    return isSuccess;
    }

  }