
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  TaskController taskController = Get.find<TaskController>();
  @override
  void initState() {
    super.initState();
    taskController.getInProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          taskController.getInProgressTask();
        },
        child: GetBuilder<TaskController>(
          builder: (_) {
            return Visibility(
              visible: taskController.getInProgressTaskScreenInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: taskController.inProgressTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: taskController.inProgressTask[index],
                      onUpdate: () {
                        taskController.getInProgressTask();
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
