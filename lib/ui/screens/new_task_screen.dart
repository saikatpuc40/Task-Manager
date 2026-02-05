
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
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
  List<TaskModel> newTaskList=[];

  @override
  void initState() {
    super.initState();
    _getNewTask();
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
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TaskSummaryCard(
                title: "New Task",
                count: "12",
              ),
              TaskSummaryCard(
                title: "Completed",
                count: "12",
              ),
              TaskSummaryCard(
                title: "In Progress",
                count: "12",
              ),
              TaskSummaryCard(
                title: "Cancelled",
                count: "12",
              ),
            ],
          ),
        );
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




