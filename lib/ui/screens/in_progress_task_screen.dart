
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _getInProgressTaskScreenInProgress = false;
  List<TaskModel> inProgressTask = [];

  @override
  void initState() {
    super.initState();
    _getInProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          _getInProgressTask();
        },
        child: Visibility(
          visible: _getInProgressTaskScreenInProgress==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: inProgressTask.length,
            itemBuilder: (context, index) {
              return TaskItem(
                  taskModel: inProgressTask[index],
                  onUpdate: () {
                    _getInProgressTask();

              },);

            },
          ),
        ),
      ),
    );
  }

  Future<void> _getInProgressTask() async {
    _getInProgressTaskScreenInProgress = true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await networkCaller.getRequest(Urls.inProgressTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      inProgressTask = taskListWrapperModel.taskList??[];
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Get Completed Task Failed!');
      }
    }
    _getInProgressTaskScreenInProgress = false;
    if(mounted){
      setState(() {});
    }


  }
}
