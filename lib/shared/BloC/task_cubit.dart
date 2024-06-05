import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/shared/BloC/task_states.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(InitialState());
}
