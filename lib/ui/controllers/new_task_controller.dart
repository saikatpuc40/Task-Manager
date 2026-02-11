import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_count_by_status.dart';
import 'package:task_manager/data/models/task_count_by_status_wrapper_model.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class NewTaskController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _getNewTaskScreenInProgress = false;
  bool _getTaskStatusSectionInProgress = false;
  List<TaskModel> _taskList = [];
  List<TaskCountByStatus> _taskCountByStatus = [];
  String _errorMessage = '';
  String _errorMessageForTaskStatus = '';

  bool get getNewTaskScreenInProgress => _getNewTaskScreenInProgress;
  List<TaskModel> get newTaskList => _taskList;
  String get errorMessage => _errorMessage;
  bool get getTaskStatusSectionInProgress => _getTaskStatusSectionInProgress;
  List<TaskCountByStatus> get taskCountByStatus => _taskCountByStatus;
  String get errorMessageForTaskStatus => _errorMessageForTaskStatus;


  Future<bool> getNewTask() async {
    bool isSuccess = false;
    _getNewTaskScreenInProgress = true;

    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.newTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      _taskList = taskListWrapperModel.taskList??[];
      isSuccess = true;
    }
    else{
      _errorMessage = response.errorMessage?? 'Get New Task Failed!';
    }
    _getNewTaskScreenInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getTaskStatus() async {
    bool isSuccess = false;
    _getTaskStatusSectionInProgress =true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.taskStatusCount);
    if(response.isSuccess){
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel = TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _taskCountByStatus = taskCountByStatusWrapperModel.taskCount??[];
      isSuccess = true;
    }
    else{
       _errorMessageForTaskStatus = response.errorMessage?? 'Get Task Status Failed!';
    }
    _getTaskStatusSectionInProgress = false;
    update();
    return isSuccess;
  }

}