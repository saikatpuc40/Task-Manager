
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    taskController.getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
             taskController.getCompletedTask();
          },
        child: GetBuilder<TaskController>(
          builder: (_) {
            return Visibility(
              visible: taskController.getCompletedTaskScreenInProgress==false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: taskController.completedTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: taskController.completedTask[index],
                      onUpdate: () {
                        taskController.getCompletedTask();
                  },

                  );
                  },
              ),
            );
          }
        ),
      ),
    );
  }



}
