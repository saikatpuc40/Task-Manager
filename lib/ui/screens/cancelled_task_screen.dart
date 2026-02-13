
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  CancelledTaskController cancelledTaskController = Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    cancelledTaskController.getcancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          cancelledTaskController.getcancelledTask();
        },
        child: Visibility(
          visible: cancelledTaskController.getCancelledTaskScreenInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: cancelledTaskController.cancelledTask.length,
            itemBuilder: (context, index) {
              return TaskItem(
                  taskModel: cancelledTaskController.cancelledTask[index],
                  onUpdate: () {
                    cancelledTaskController.getcancelledTask();

              },);

            },
          ),
        ),
      ),
    );
  }

}
