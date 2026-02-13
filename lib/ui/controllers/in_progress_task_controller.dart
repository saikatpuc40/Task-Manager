import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class InProgressTaskController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _getInProgressTaskScreenInProgress = false;
  List<TaskModel> _inProgressTask = [];
  String _errorMessage ='';

  bool get getInProgressTaskScreenInProgress => _getInProgressTaskScreenInProgress;
  List<TaskModel> get inProgressTask => _inProgressTask;
  String get errorMessage => _errorMessage;

  Future<bool> getInProgressTask() async {
    bool isSuccess =false;
    _getInProgressTaskScreenInProgress = true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.inProgressTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      _inProgressTask = taskListWrapperModel.taskList??[];
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage?? 'Get Completed Task Failed!';
    }
    _getInProgressTaskScreenInProgress = false;
    update();
    return isSuccess;


  }
}