
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utilities/urls.dart';
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
    taskController.fetchTasks("Completed", Urls.completedTask);
  }

  @override
  Widget build(BuildContext context) {
    final completedTask = taskController.taskMap["Completed"]??[];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
             taskController.fetchTasks("Completed",Urls.completedTask);
          },
        child: GetBuilder<TaskController>(
          builder: (_) {
            return Visibility(
              visible: taskController.isLoading == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: completedTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel:completedTask[index],
                      onUpdate: () {
                        taskController.fetchTasks("Completed",Urls.completedTask);
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
