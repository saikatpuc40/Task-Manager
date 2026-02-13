import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class CancelledTaskController extends GetxController{
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _getCancelledTaskScreenInProgress = false;
  List<TaskModel> _cancelledTask = [];
  String _errorMessage ='';

  bool get getCancelledTaskScreenInProgress => _getCancelledTaskScreenInProgress;
  List<TaskModel> get cancelledTask => _cancelledTask;
  String get errorMessage => _errorMessage;


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
}