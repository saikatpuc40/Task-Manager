import 'package:get/get.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_count_by_status.dart';
import 'package:task_manager/data/models/task_count_by_status_wrapper_model.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';

class TaskController extends GetxController {
  NetworkCaller networkCaller = Get.find<NetworkCaller>();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Map<String, List<TaskModel>> taskMap = {
    "New": [],
    "In Progress": [],
    "Completed": [],
    "Cancelled": []
  };
  List<TaskCountByStatus> taskCountByStatus = [];

  Future<void> fetchTasks(String status, String url) async {
    try {
      _isLoading = true;
      update();
      NetworkResponse response = await networkCaller.getRequest(url);
      if (response.isSuccess) {
        TaskListWrapperModel taskListWrapperModel = TaskListWrapperModel
            .fromJson(response.responseData);
        taskMap[status] = taskListWrapperModel.taskList ?? [];
      }
      else {
        _errorMessage = response.errorMessage ?? "Failed to load tasks";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      update();
    }
  }


  Future<void> fetchTaskStatusCount() async {
    try {
      _isLoading = true;
      update();
      NetworkResponse response = await networkCaller.getRequest(
          Urls.taskStatusCount);
      if (response.isSuccess) {
        TaskCountByStatusWrapperModel taskCountByStatusWrapperModel = TaskCountByStatusWrapperModel
            .fromJson(response.responseData);
        taskCountByStatus = taskCountByStatusWrapperModel.taskCount ?? [];
      }
      else {
        _errorMessage = response.errorMessage ?? 'Failed to load Task Status!';
      }
    }
    catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<bool> addTask(String title, String description) async {
    try {
      _isLoading = true;
      update();

      NetworkResponse response =
      await networkCaller.postRequest(
        Urls.createTask,
        body: {
          "title": title,
          "description": description,
          "status": "New",
        },
      );

      if (response.isSuccess) {
        await fetchTasks("New", Urls.newTask);
        await fetchTaskStatusCount();
        return true;
      } else {
        _errorMessage =
            response.errorMessage ?? "Add task failed";
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<bool> deleteTask(String id, String status) async {
    try {
      _isLoading = true;
      update();

      NetworkResponse response =
      await networkCaller.getRequest(
          Urls.deleteTask(id));

      if (response.isSuccess) {
        // Remove locally instead of refetch all
        taskMap[status]?.removeWhere(
                (task) => task.sId == id);

        await fetchTaskStatusCount();
        return true;
      } else {
        _errorMessage =
            response.errorMessage ?? "Delete failed";
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<bool> updateTaskStatus(String id,
      String oldStatus,
      String newStatus) async {
    try {
      _isLoading = true;
      update();

      NetworkResponse response =
      await networkCaller.getRequest(
          Urls.updateTask(id, newStatus));

      if (response.isSuccess) {
        final task = taskMap[oldStatus]
            ?.firstWhere((t) => t.sId == id);

        if (task != null) {
          taskMap[oldStatus]?.remove(task);
          task.status = newStatus;
          taskMap[newStatus]?.add(task);
        }

        await fetchTaskStatusCount();
        return true;
      } else {
        _errorMessage =
            response.errorMessage ?? "Update failed";
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      update();
    }
  }
}