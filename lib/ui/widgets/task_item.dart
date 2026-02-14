import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key, required this.taskModel, required this.onUpdate,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdate;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  NewTaskController newTaskController = Get.find<NewTaskController>();
  String dropdownValue = '';
  List<String> statusList = ['New', 'In Progress', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text('Date : ${widget.taskModel.createdDate}', style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(widget.taskModel.status ?? "New",
                  style: TextStyle(color: Colors.white),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                ),
                ButtonBar(
                  children: [
                    GetBuilder<NewTaskController>(
                        builder: (_) {
                          return Visibility(
                            visible: newTaskController.deleteTaskInProgress == false,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: IconButton(onPressed: () {
                              _deleteTask();
                            }, icon: Icon(Icons.delete)),
                          );
                        }
                    ),
                    PopupMenuButton<String>(
                        icon: const Icon(Icons.edit),
                        onSelected: (String selectedValue) {
                          dropdownValue = selectedValue;
                          debugPrint(dropdownValue);
                          _updateTask();
                        },
                        itemBuilder: (BuildContext context) {
                          return statusList.map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: ListTile(
                                  title: Text(value),
                                  trailing: dropdownValue == value
                                      ? const Icon(Icons.done)
                                      : null
                              ),
                            );
                          }).toList();
                        }
                    ),
                  ],

                )
              ],

            )
          ],

        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    final bool result = await newTaskController.deleteTask(
        widget.taskModel.sId!);
    if (result) {

    }
    else {
      if (mounted) {
        showSnackBarMessage(
            context, newTaskController.errorMessageForDeleteTask);
      }
    }
  }


  Future<void> _updateTask() async {
    final bool result = await newTaskController.updateTask(
        widget.taskModel.sId!, dropdownValue);
    if (result) {

    }
    else {
      if (mounted) {
        showSnackBarMessage(
            context, newTaskController.errorMessageForUpdateTask);
      }
    }
  }
}