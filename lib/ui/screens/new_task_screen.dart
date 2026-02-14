
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
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
  NewTaskController newTaskController = Get.find();

  @override
  void initState() {
    super.initState();
    newTaskController.getNewTask();
    newTaskController.getTaskStatus();
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
              child: GetBuilder<NewTaskController>(
                builder: (_) {
                  if(newTaskController.isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      newTaskController.getNewTask();
                      newTaskController.getTaskStatus();
                    },
                      child: ListView.builder(
                                itemCount: newTaskController.newTaskList.length,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                    taskModel: newTaskController.newTaskList[index],
                                    onUpdate: () {
                                      newTaskController.getNewTask();
                                      newTaskController.getTaskStatus();
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
    return GetBuilder<NewTaskController>(
        builder: (_) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: newTaskController.taskCountByStatus.map((e) {
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




