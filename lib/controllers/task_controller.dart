import 'package:get/get.dart';
import 'package:my_todo/db/db_services.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  RxList<Task> tasksList = <Task>[].obs;

  getTask() async {
    final List<Map<String, dynamic>> tasks = await DbServices.query();
    tasksList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
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
