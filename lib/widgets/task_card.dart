import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_app/themes/app_color.dart';

class TaskCard extends StatefulWidget {
  final bool? isChecked;

  const TaskCard({super.key, this.isChecked});
  @override
  State<TaskCard> createState() => _TaskCardState(isChecked: isChecked);
}

class _TaskCardState extends State<TaskCard> {
  bool? isChecked;

  _TaskCardState({required this.isChecked});
  @override
  Widget build(BuildContext context) {
    return Material(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Build UI Android',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Due Date: Mon. 21/3/2024',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: isChecked,
                  onChanged: (newValue) {
                    setState(() {
                      isChecked = newValue;
                    });
                  },
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return AppColors.secondary;
                  }),
                  checkColor: AppColors.primary,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
