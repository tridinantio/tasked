import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasked/models/task_model.dart';
import 'package:tasked/services/task_services.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void fetchTasks() async {
    try {
      emit(TaskLoading());

      List<TaskModel> tasks = await TaskService().fetchTasks();

      emit(TaskSuccess(tasks));
    } catch (e) {
      emit(TaskFailed(e.toString()));
    }
  }

  void createTask(TaskModel task) async {
    try {
      emit(TaskLoading());
      await TaskService().createTask(task);
      fetchTasks();
    } catch (e) {
      emit(TaskFailed(e.toString()));
    }
  }

  void deleteTask(TaskModel task) async {
    try {
      emit(TaskLoading());
      await TaskService().deleteTask(task);
      fetchTasks();
    } catch (e) {
      emit(TaskFailed(e.toString()));
    }
  }
}
