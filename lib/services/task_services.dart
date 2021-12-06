import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasked/models/task_model.dart';

class TaskService {
  CollectionReference _taskReference =
      FirebaseFirestore.instance.collection('task');

  Future<void> createTask(TaskModel task) async {
    try {
      _taskReference.add({'title': task.title, 'note': task.note});
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    try {
      _taskReference.doc(task.id).delete();
    } catch (e) {
      throw e;
    }
  }

  Future<List<TaskModel>> fetchTasks() async {
    try {
      QuerySnapshot result =
          await _taskReference.orderBy('title', descending: true).get();
      List<TaskModel> tasks = result.docs.map((e) {
        return TaskModel.fromJson(e.id, e.data() as Map<String, dynamic>);
      }).toList();

      return tasks;
    } catch (e) {
      throw e;
    }
  }
}
