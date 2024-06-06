import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/themes/app_color.dart';
import '../shared/BloC/task_cubit.dart';

class CreateTaskButton extends StatefulWidget {
  const CreateTaskButton({super.key});

  @override
  State<CreateTaskButton> createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState extends State<CreateTaskButton> {
  String? taskTitle;
  String? taskDate;
  TextEditingController dateInput = TextEditingController();
  TextEditingController controller = TextEditingController();
  // String? task_date = "Mon, 5/6/2024";
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 53),
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          barrierColor: Colors.transparent,
          // backgroundColor: Colors.white,
          elevation: 5,
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white),
                  height: 270,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      const Text(
                        'Create New Task',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        onChanged: (value) {
                          taskTitle = value;
                          controller.clear();
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff7f7f7),
                            contentPadding: const EdgeInsets.all(12),
                            hintText: 'Task title',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        onChanged: (value) {},
                        controller:
                            dateInput, //editing controller of this TextField
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff7f7f7),
                          contentPadding: const EdgeInsets.all(12),
                          hintText: 'Due Date',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                  15)), //icon of text field
                        ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: AppColors
                                            .primary, // header background color
                                        surface: Colors.white,
                                        onPrimary:
                                            Colors.white, // header text color
                                        onSurface:
                                            Colors.black, // body text color
                                      ),
                                    ),
                                    child: child!);
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('E. yyyy/MM/dd').format(pickedDate);
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                            taskDate = dateInput.text;
                          } else {}
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 53),
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 64, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          var taskCubit = BlocProvider.of<TaskCubit>(context);
                          taskCubit.addTask(
                              taskTitle: "$taskTitle", taskDate: "$taskDate");
                          Navigator.pop(context);
                          dateInput.clear();
                        },
                        child: const Text(
                          'Save Task',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Text(
        'Create Task',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
