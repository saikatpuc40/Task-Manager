
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  NewTaskController newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    newTaskController.getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
             newTaskController.getCompletedTask();
          },
        child: GetBuilder<NewTaskController>(
          builder: (_) {
            return Visibility(
              visible: newTaskController.getCompletedTaskScreenInProgress==false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: newTaskController.completedTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: newTaskController.completedTask[index],
                      onUpdate: () {
                        newTaskController.getCompletedTask();
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
