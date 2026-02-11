
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  bool _getCancelledTaskScreenInProgress = false;
  List<TaskModel> cancelledTask = [];

  @override
  void initState() {
    super.initState();
    _getcancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          _getcancelledTask();
        },
        child: Visibility(
          visible: _getCancelledTaskScreenInProgress==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: cancelledTask.length,
            itemBuilder: (context, index) {
              return TaskItem(
                  taskModel: cancelledTask[index],
                  onUpdate: () {
                    _getcancelledTask();

              },);

            },
          ),
        ),
      ),
    );
  }
  Future<void> _getcancelledTask() async {
    _getCancelledTaskScreenInProgress = true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await networkCaller.getRequest(Urls.cancelledTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      cancelledTask = taskListWrapperModel.taskList??[];
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Get Completed Task Failed!');
      }
    }
    _getCancelledTaskScreenInProgress = false;
    if(mounted){
      setState(() {});
    }


  }
}
