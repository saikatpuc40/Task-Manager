
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/task_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:task_manager/ui/widgets/task_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item.dart';



class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TaskController taskController = Get.find<TaskController>();



  @override
  void initState() {
    super.initState();
    taskController.fetchTasks("New",Urls.newTask);
    taskController.fetchTaskStatusCount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummarySection(),
            const SizedBox(height: 8,),
            Expanded(
              child: GetBuilder<TaskController>(
                builder: (_) {
                  if(taskController.isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final newTasks = taskController.taskMap["New"]??[];
                  return RefreshIndicator(
                    onRefresh: () async {
                      taskController.fetchTasks("New", Urls.newTask);
                      taskController.fetchTaskStatusCount();
                    },
                      child: ListView.builder(
                                itemCount: newTasks.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                    taskModel: newTasks[index],
                                    onUpdate: () {
                                      taskController.fetchTasks("New", Urls.newTask);
                                      taskController.fetchTaskStatusCount();
                                    },
                                  );
                                },
                              )
                          );
                }
              )
            )
          ]
      )
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
    return GetBuilder<TaskController>(
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: taskController.taskCountByStatus.map((e) {
                  return TaskSummaryCard(
                    title: e.sId ?? " UnKnown ".toLowerCase(),
                    count: e.sum.toString(),
                  );
                },).toList()
            ),
          );
        }
    );
  }
}




