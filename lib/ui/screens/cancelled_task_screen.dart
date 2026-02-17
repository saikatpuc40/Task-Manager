
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    taskController.getcancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          taskController.getcancelledTask();
        },
        child: GetBuilder<TaskController>(
          builder: (_) {
            return Visibility(
              visible: taskController.getCancelledTaskScreenInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: taskController.cancelledTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: taskController.cancelledTask[index],
                      onUpdate: () {
                        taskController.getcancelledTask();

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
