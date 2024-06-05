import 'package:flutter/material.dart';
import 'package:task_app/themes/app_color.dart';

class CreateTaskButton extends StatefulWidget {
  @override
  State<CreateTaskButton> createState() => _CreateTaskButtonState();
}

class _CreateTaskButtonState extends State<CreateTaskButton> {
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
        setState(() {
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
                    height: 262,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Row(
                          children: [
                            Spacer(),
                            Icon(
                              Icons.close,
                              color: Colors.red,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Create New Task',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          onSubmitted: (value) {},
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
                        TextField(
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xfff7f7f7),
                              contentPadding: EdgeInsets.all(12),
                              hintText: 'Due Date',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15))),
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
                            setState(() {
                              Navigator.pop(context);
                            });
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
        });
      },
      child: const Text(
        'Create Task',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
