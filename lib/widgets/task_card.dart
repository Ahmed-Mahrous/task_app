import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/shared/BloC/task_cubit.dart';
import 'package:task_app/themes/app_color.dart';
import 'package:task_app/widgets/edit_button.dart';
import '../shared/BloC/task_states.dart';

class TaskCard extends StatefulWidget {
  final String? taskTitle;
  final String? taskDate;
  final String? taskKey;
  final String? docId;
  final Color? checkColor;

  const TaskCard(
      {super.key,
      this.taskTitle,
      this.taskKey,
      this.taskDate,
      this.docId,
      this.checkColor});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            var taskCubit = BlocProvider.of<TaskCubit>(context);
            if (widget.checkColor == AppColors.checkColor) {
              taskCubit.deleteTask(docId: "${widget.docId}");
            } else {
              taskCubit.deleteDoneTask(docId: "${widget.docId}");
            }
          },
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.transparent,
            elevation: 3,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.taskTitle}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Due Date: ${widget.taskDate}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      widget.checkColor == AppColors.checkColor
                          ? Row(
                              children: [
                                EditButton(docId: '${widget.docId}'),
                                Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                    value: true,
                                    onChanged: (value) {
                                      var taskCubit =
                                          BlocProvider.of<TaskCubit>(context);
                                      if (widget.checkColor ==
                                          AppColors.checkColor) {
                                        taskCubit.addDoneTask(
                                            taskTitle: '${widget.taskTitle}',
                                            taskDate: '${widget.taskDate}');
                                        taskCubit.deleteTask(
                                            docId: '${widget.docId}');
                                      } else {
                                        taskCubit.addTask(
                                            taskTitle: '${widget.taskTitle}',
                                            taskDate: '${widget.taskDate}');
                                        taskCubit.deleteDoneTask(
                                            docId: '${widget.docId}');
                                      }
                                    },
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      return AppColors.secondary;
                                    }),
                                    checkColor: widget.checkColor,
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: true,
                                onChanged: (value) {
                                  var taskCubit =
                                      BlocProvider.of<TaskCubit>(context);
                                  if (widget.checkColor ==
                                      AppColors.checkColor) {
                                    taskCubit.addDoneTask(
                                        taskTitle: '${widget.taskTitle}',
                                        taskDate: '${widget.taskDate}');
                                    taskCubit.deleteTask(
                                        docId: '${widget.docId}');
                                  } else {
                                    taskCubit.addTask(
                                        taskTitle: '${widget.taskTitle}',
                                        taskDate: '${widget.taskDate}');
                                    taskCubit.deleteDoneTask(
                                        docId: '${widget.docId}');
                                  }
                                },
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  return AppColors.secondary;
                                }),
                                checkColor: widget.checkColor,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
