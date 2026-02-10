class Urls{
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask ='$_baseUrl/createTask';
  static const String newTask ='$_baseUrl/listTaskByStatus/New';
  static const String completedTask ='$_baseUrl/listTaskByStatus/Completed';
  static const String inProgressTask ='$_baseUrl/listTaskByStatus/In Progress';
  static const String cancelledTask ='$_baseUrl/listTaskByStatus/Cancelled';
  static const String taskStatusCount ='$_baseUrl/taskStatusCount';
  static const String profileUpdate ='$_baseUrl/profileUpdate';
  static const String recoverPasswordSetTask = '$_baseUrl/RecoverResetPass';
  static String emailVerificationTask(String id) => '$_baseUrl/RecoverVerifyEmail/$id';
  static String verifyPinTask(String id,String status) => '$_baseUrl/RecoverVerifyOTP/$id/$status';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTask(String id,String status) => '$_baseUrl/updateTaskStatus/$id/$status';
}