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

  bool get isLoading => _getNewTaskScreenInProgress||_getTaskStatusSectionInProgress;

  bool _getNewTaskScreenInProgress = false;
  bool _getTaskStatusSectionInProgress = false;
  List<TaskModel> _taskList = [];
  List<TaskCountByStatus> _taskCountByStatus = [];
  String _errorMessage = '';
  String _errorMessageForTaskStatus = '';

  List<TaskModel> get newTaskList => _taskList;
  String get errorMessage => _errorMessage;
  List<TaskCountByStatus> get taskCountByStatus => _taskCountByStatus;
  String get errorMessageForTaskStatus => _errorMessageForTaskStatus;

  bool _deleteTaskInProgress =false;
  String _errorMessageForDeleteTask = '';
  String get errorMessageForDeleteTask => _errorMessageForDeleteTask;
  bool get deleteTaskInProgress => _deleteTaskInProgress;



  bool _updateTaskInProgress =false;
  String _errorMessageForUpdateTask = '';
  String get errorMessageForUpdateTask => _errorMessageForUpdateTask;
  bool get updateTaskInProgress => _updateTaskInProgress;


  bool _addNewTaskInProgress = false;
  String _errorMessageForAddNewTask = '';

  bool get addNewTaskInProgress => _addNewTaskInProgress;
  String get errorMessageForAddNewTask => _errorMessageForAddNewTask;
  bool _getCompletedTaskScreenInProgress = false;
  List<TaskModel> _completedTask = [];
  String _errorMessageForCompletedTask ='';

  List<TaskModel> get completedTask => _completedTask;
  String get errorMessageForCompletedTask => _errorMessageForCompletedTask;
  bool get getCompletedTaskScreenInProgress => _getCompletedTaskScreenInProgress;

  bool _getCancelledTaskScreenInProgress = false;
  List<TaskModel> _cancelledTask = [];
  String _errorMessage ='';

  bool get getCancelledTaskScreenInProgress => _getCancelledTaskScreenInProgress;
  List<TaskModel> get cancelledTask => _cancelledTask;
  String get errorMessage => _errorMessage;

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

  Future<bool> getcancelledTask() async {
    bool isSuccess =false;
    _getCancelledTaskScreenInProgress = true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.cancelledTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      _cancelledTask = taskListWrapperModel.taskList??[];
      isSuccess = true;
    }
    else{
      _errorMessage=response.errorMessage?? 'Get Completed Task Failed!';
    }
    _getCancelledTaskScreenInProgress = false;
    update();
    return isSuccess;


  }

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
      // final taskData = response.responseData['data'];
      // _taskList.add(TaskModel.fromJson(taskData));
      await getNewTask();
      await getTaskStatus();
      isSuccess =true;
    }
    else{
      _errorMessageForAddNewTask = response.errorMessage?? "Task Added Failed!.Try Again.";
    }
    _addNewTaskInProgress = false;
    update();
    return isSuccess;

  }

  Future<bool> deleteTask(String taskId) async {
    bool isSuccess = false;
    _deleteTaskInProgress =true;
    update();
    NetworkResponse response = await networkCaller.getRequest(Urls.deleteTask(taskId));
    if(response.isSuccess){
      _taskList.removeWhere((task) => task.sId == taskId);
      await getTaskStatus();
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