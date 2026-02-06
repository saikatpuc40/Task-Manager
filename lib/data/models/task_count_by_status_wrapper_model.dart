import 'package:task_manager/data/models/task_count_by_status.dart';

class TaskCountByStatusWrapperModel {
  String? status;
  List<TaskCountByStatus>? taskCount;

  TaskCountByStatusWrapperModel({this.status, this.taskCount});

  TaskCountByStatusWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCount = <TaskCountByStatus>[];
      json['data'].forEach((v) {
        taskCount!.add(TaskCountByStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCount != null) {
      data['data'] = taskCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

