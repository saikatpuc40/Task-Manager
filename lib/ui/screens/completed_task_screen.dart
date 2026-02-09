
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool _getCompletedTaskScreenInProgress = false;
  List<TaskModel> completedTask = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTask();
          },
        child: Visibility(
          visible: _getCompletedTaskScreenInProgress==false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: completedTask.length,
            itemBuilder: (context, index) {
              return TaskItem(
                  taskModel: completedTask[index],
                  onUpdate: () {
                    _getCompletedTask();
              },

              );
              },
          ),
        ),
      ),
    );
  }


  Future<void> _getCompletedTask() async {
    _getCompletedTaskScreenInProgress = true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      completedTask = taskListWrapperModel.taskList??[];
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Get Completed Task Failed!');
      }
    }
    _getCompletedTaskScreenInProgress = false;
    if(mounted){
      setState(() {});
    }


  }
}
