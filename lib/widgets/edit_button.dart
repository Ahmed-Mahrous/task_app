import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/themes/app_color.dart';
import 'package:task_app/widgets/date_field.dart';

import '../shared/BloC/task_cubit.dart';
import '../shared/BloC/task_states.dart';

class EditButton extends StatefulWidget {
  final String docId;

  const EditButton({super.key, required this.docId});
  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  String? task_title;
  String? task_date;

  TextEditingController dateinput = TextEditingController();
  TextEditingController controller = TextEditingController();

  _EditButtonState();
  // String? task_date = "Mon, 5/6/2024";
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.edit,
        color: AppColors.primary,
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
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
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
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
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
                      Text(
                        'Edit Your Task',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        onChanged: (value) {
                          task_title = value;
                          controller.clear();
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff7f7f7),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'Task title',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //DateField(),
                      TextField(
                        onChanged: (value) {},
                        controller:
                            dateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xfff7f7f7),
                          contentPadding: EdgeInsets.all(12),
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
                                      colorScheme: ColorScheme.light(
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
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('E. yyyy/MM/dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                            task_date = dateinput.text;
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                      Spacer(),
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
                          taskCubit.editTask(
                              docId: "${widget.docId}",
                              taskTitle: "$task_title",
                              taskDate: "$task_date");
                          Navigator.pop(context);
                          dateinput.clear();
                        },
                        child: const Text(
                          'Save Edit',
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
    );
  }
}
