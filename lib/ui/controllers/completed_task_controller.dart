import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class CompletedTaskController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _getCompletedTaskScreenInProgress = false;
  List<TaskModel> _completedTask = [];
  String _errorMessage ='';

  List<TaskModel> get completedTask => _completedTask;
  String get errorMessage => _errorMessage;
  bool get getCompletedTaskScreenInProgress => _getCompletedTaskScreenInProgress;


  Future<bool> getCompletedTask() async {
    bool isSuccess =false;
    _getCompletedTaskScreenInProgress = true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.completedTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      _completedTask = taskListWrapperModel.taskList??[];
      isSuccess = true;
    }
    else{
      _errorMessage= response.errorMessage?? 'Get Completed Task Failed!';
    }
    _getCompletedTaskScreenInProgress = false;
    update();
    return isSuccess;


  }
}