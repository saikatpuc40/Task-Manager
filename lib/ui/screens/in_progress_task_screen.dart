
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/in_progress_task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {

  NetworkCaller networkCaller = Get.find<NetworkCaller>();
  InProgressTaskController inProgressTaskController = Get.find<InProgressTaskController>();

  @override
  void initState() {
    super.initState();
    inProgressTaskController.getInProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          inProgressTaskController.getInProgressTask();
        },
        child: GetBuilder<InProgressTaskController>(
          builder: (_) {
            return Visibility(
              visible: inProgressTaskController.getInProgressTaskScreenInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: inProgressTaskController.inProgressTask.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                      taskModel: inProgressTaskController.inProgressTask[index],
                      onUpdate: () {
                        inProgressTaskController.getInProgressTask();
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
