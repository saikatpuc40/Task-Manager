
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  CompletedTaskController completedTaskController = Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    completedTaskController.getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
             completedTaskController.getCompletedTask();
          },
        child: GetBuilder<CompletedTaskController>(
          builder: (_) {
            return Visibility(
              visible: completedTaskController.getCompletedTaskScreenInProgress==false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: completedTaskController.completedTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: completedTaskController.completedTask[index],
                      onUpdate: () {
                        completedTaskController.getCompletedTask();
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
