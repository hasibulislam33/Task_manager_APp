import 'package:todo_project/uiView/cancel_task_list.dart';

class Urls {
  static final _baseurl = "https://task-manager-api.ostad.live/api/v1";
  static final Registration = "$_baseurl/Registration";
  static final Login = "$_baseurl/Login";
  static final profileUpdate = "$_baseurl/ProfileUpdate";
  static final addnewtask = "$_baseurl/createTask";
  static final newtaskList = "$_baseurl/listTaskByStatus/New";
  static final  postreq = "$_baseurl/listTaskByStatus/New";
  static final taskStattus = "$_baseurl/taskStatusCount";
  static final progressTasklist = "$_baseurl/listTaskByStatus/Progress";
  static final CancelTaskList = "$_baseurl/listTaskByStatus/Cancel";
  static final CompleteTaskList = "$_baseurl/listTaskByStatus/Complete";
  static updateStatus(String id, String status) => "$_baseurl/updateTaskStatus/$id/$status";
  static deleteTask(String id)=> "$_baseurl/deleteTask/$id";
}