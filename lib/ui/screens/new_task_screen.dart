
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_count_by_status.dart';
import 'package:task_manager/data/models/task_count_by_status_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item.dart';



class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskScreenInProgress = false;
  bool _getTaskStatusSectionInProgress = false;
  List<TaskModel> newTaskList=[];
  List<TaskCountByStatus> taskCountByStatus = [];

  @override
  void initState() {
    super.initState();
    _getNewTask();
    _getTaskStatus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(height: 8,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                  _getNewTask();
                  _getTaskStatus();
                },
                child: Visibility(
                visible: _getNewTaskScreenInProgress==false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index],
                        onUpdate: (){
                          _getNewTask();
                          _getTaskStatus();
                        },
                      );

                    },
                  ),
                            ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _onTapAddButton,
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }


  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewTaskScreen()
      ),
    );
  }

  Widget _buildSummarySection() {
    return Visibility(
      visible: _getTaskStatusSectionInProgress==false,
      replacement: SizedBox(
        height: 100,
          child:Center(
            child: CircularProgressIndicator(),
          ) ,
        ),
      child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: taskCountByStatus.map((e){
                return TaskSummaryCard(
                  title: e.sId??" UnKnown ".toLowerCase(),
                  count: e.sum.toString(),
                );
              },).toList()
            ),
          ),
    );
  }

  Future<void> _getTaskStatus() async {
    _getTaskStatusSectionInProgress =true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.taskStatusCount);
    if(response.isSuccess){
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel = TaskCountByStatusWrapperModel.fromJson(response.responseData);
      taskCountByStatus = taskCountByStatusWrapperModel.taskCount??[];
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Get Task Status Failed!');
      }
    }
    _getTaskStatusSectionInProgress = false;
    if(mounted){
      setState(() {});
    }
  }

  Future<void> _getNewTask() async {
    _getNewTaskScreenInProgress = true;
    if(mounted){
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);
    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.taskList??[];
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage?? 'Get New Task Failed!');
      }
    }
    _getNewTaskScreenInProgress = false;
    if(mounted){
      setState(() {});
    }


  }

}




