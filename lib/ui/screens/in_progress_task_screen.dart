
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  NewTaskController newTaskController = Get.find<NewTaskController>();
  @override
  void initState() {
    super.initState();
    newTaskController.getInProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          newTaskController.getInProgressTask();
        },
        child: GetBuilder<NewTaskController>(
          builder: (_) {
            return Visibility(
              visible: newTaskController.getInProgressTaskScreenInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: newTaskController.inProgressTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: newTaskController.inProgressTask[index],
                      onUpdate: () {
                        newTaskController.getInProgressTask();
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
