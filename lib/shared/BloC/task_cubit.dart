import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/shared/BloC/task_states.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitialState());

  // Create a CollectionReference called tasks that references the FireStore collection
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  CollectionReference doneTasks =
      FirebaseFirestore.instance.collection('done_tasks');
  Future<void> addTask(
      {required final String taskTitle, required final String taskDate}) {
    // Call the user's CollectionReference to add a new task
    return tasks.add({
      'task_title': taskTitle,
      'task_date': taskDate,
    }).then((value) {
      emit(AllTasksState());
    }).catchError((error) {
      emit(NoTasksState());
    });
  }

  //delete doc from tasks collection
  Future<void> deleteTask({required final String docId}) {
    return tasks.doc(docId).delete().then((value) {
      emit(DeleteTaskState());
    }).catchError((error) => print("Failed to delete task: $error"));
  }

//delete doc from done_tasks collection
  Future<void> deleteDoneTask({required final String docId}) {
    return doneTasks.doc(docId).delete().then((value) {
      emit(DeleteTaskState());
    }).catchError((error) => print("Failed to delete Done task: $error"));
  }

  //switch task from tasks collection to done_tasks collection
  Future<void> addDoneTask(
      {required final String taskTitle, required final String taskDate}) {
    // Call the user's CollectionReference to add a new user
    return doneTasks.add({
      'task_title': taskTitle,
      'task_date': taskDate,
    }).then((value) {
      emit(DoneTasksState());
    }).catchError((error) {
      emit(NoTasksState());
    });
  }

  editTask(
      {required final String taskTitle,
      required final String taskDate,
      required final String docId}) async {
    await tasks.doc(docId).update({
      'task_title': taskTitle,
      'task_date': taskDate,
    });
    emit(EditTasksState());
  }
}
