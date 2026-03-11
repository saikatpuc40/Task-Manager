
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/controllers/task_controller.dart';
import 'package:task_manager/ui/widgets/empty_list_widget.dart';
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
    taskController.fetchTasks("In Progress", Urls.inProgressTask);
  }
  @override
  Widget build(BuildContext context) {
    print('In Progress Task Screen');
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async {
          taskController.fetchTasks("In Progress", Urls.inProgressTask);
        },
        child: GetBuilder<TaskController>(
          builder: (_) {
            final inProgressTask = taskController.taskMap["In Progress"]??[];
            if(inProgressTask.isEmpty){
              return const Center(
                child: EmptyListWidget(),
              );
            }
            return Visibility(
              visible: taskController.isLoading == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                itemCount: inProgressTask.length,
                itemBuilder: (context, index) {

                  return TaskItem(
                      taskModel: inProgressTask[index],
                      onUpdate: () {
                        taskController.fetchTasks("In Progress", Urls.inProgressTask);
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
