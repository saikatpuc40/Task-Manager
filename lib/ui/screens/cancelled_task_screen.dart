
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  NewTaskController newTaskController = Get.find<NewTaskController>();


  @override
  void initState() {
    super.initState();
    newTaskController.getcancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          newTaskController.getcancelledTask();
        },
        child: GetBuilder<NewTaskController>(
          builder: (_) {
            return Visibility(
              visible: newTaskController.getCancelledTaskScreenInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: newTaskController.cancelledTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: newTaskController.cancelledTask[index],
                      onUpdate: () {
                        newTaskController.getcancelledTask();

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
