import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/shared/BloC/task_states.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitialState());

  // Create a CollectionReference called tasks that references the firestore collection
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  CollectionReference done_tasks =
      FirebaseFirestore.instance.collection('done_tasks');
  Future<void> addTask(
      {required final String taskTitle, required final String taskDate}) {
    // Call the user's CollectionReference to add a new user
    return tasks.add({
      'task_title': taskTitle, // John Doe
      'task_date': taskDate, // Stokes and Sons
    }).then((value) {
      print("Task Added");
      emit(AllTasksState());
    }).catchError((error) {
      print("Failed to add task: $error");
      emit(NoTasksState());
    });
  }

  Future<void> deleteTask({required final String docId}) {
    return tasks.doc('$docId').delete().then((value) {
      print("Task Deleted");
      emit(DeleteTaskState());
    }).catchError((error) => print("Failed to delete task: $error"));
  }

  Future<void> deleteDoneTask({required final String docId}) {
    return done_tasks.doc('$docId').delete().then((value) {
      print("Done Task Deleted");
      emit(DeleteTaskState());
    }).catchError((error) => print("Failed to delete Done task: $error"));
  }

  Future<void> addDoneTask(
      {required final String taskTitle, required final String taskDate}) {
    // Call the user's CollectionReference to add a new user
    return done_tasks.add({
      'task_title': taskTitle,
      'task_date': taskDate,
    }).then((value) {
      print("done Task Added");
      emit(DoneTasksState());
    }).catchError((error) {
      print("Failed to add done task: $error");
      emit(NoTasksState());
    });
  }

  editTask(
      {required final String taskTitle,
      required final String taskDate,
      required final String docId}) async {
    await tasks.doc('$docId').update({
      'task_title': taskTitle,
      'task_date': taskDate,
    });
    emit(EditTasksState());
  }
}
