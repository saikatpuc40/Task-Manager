
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  TaskController taskController = Get.find<TaskController>();


  @override
  void initState() {
    super.initState();
    taskController.fetchTasks("Cancelled", Urls.cancelledTask);
  }

  @override
  Widget build(BuildContext context) {

    final cancelledTask = taskController.taskMap["Cancelled"]??[];
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          taskController.fetchTasks("Cancelled", Urls.cancelledTask);
        },
        child: GetBuilder<TaskController>(
          builder: (_) {
            return Visibility(
              visible: taskController.isLoading == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: cancelledTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: cancelledTask[index],
                      onUpdate: () {
                        taskController.fetchTasks("Cancelled", Urls.cancelledTask);

                  },);

                },
              ),
            );
          }
        ),
      ),
    );
  }

}
