import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_todo/db/db_services.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasksList = <Task>[].obs;

  RxList<Task> listHelper = <Task>[].obs;

  // tasksHelper(DateTime selectedDate) {
  //   debugPrint('tasksList : $tasksList');
  //   debugPrint('selectedList 1 : ${HomeScreen.selectedList}');
  //   Iterable<Task> tasks = tasksList
  //       .where((task) => task.date == DateFormat.yMd().format(selectedDate));
  //   HomeScreen.selectedList.contains(tasks)
  //       ? null
  //       : HomeScreen.selectedList.addAll(tasks);
  //   debugPrint('selectedList 2 : ${HomeScreen.selectedList}');
  // }
  // void checkListHelper(DateTime selectedDate) {
  //   Iterable<Task> tempTasks = tasksList
  //       .where((task) => task.date == DateFormat.yMd().format(selectedDate));
  //   listHelper.assignAll(tempTasks);
  //   debugPrint('List Helper was Checked');
  //   update();
  // }

  // void clearListHelper() {
  //   listHelper.clear();
  //   debugPrint('List Helper was Cleared');
  //   update();
  // }

  getTask({DateTime? selectedDate}) async {
    final List<Map<String, dynamic>> tasks = await DbServices.query();
    tasksList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
    if (selectedDate != null) {
      Iterable<Task> tempTasks = tasksList
          .where((task) => task.date == DateFormat.yMd().format(selectedDate));
      listHelper.assignAll(tempTasks);
      debugPrint('ListHelper : $listHelper');
    }
    update();
  }

  Future<int> insertTask({required Task task}) {
    return DbServices.insert(task);
  }

  deleteTask({required int id}) async {
    await DbServices.delete(id);
    getTask();
  }

  deleteAllTask() async {
    await DbServices.deleteAll();
    getTask();
  }

  completeTask({required Task task}) async {
    await DbServices.complete(task);
    getTask();
  }

  updateTask({required Task task}) async {
    await DbServices.update(task);
    getTask();
  }
}
