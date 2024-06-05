import 'package:flutter/material.dart';
import 'package:task_app/widgets/create_task_button.dart';
import '../../widgets/task_card.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            children: [
              TaskCard(
                isChecked: false,
              ),
              SizedBox(
                height: 15,
              ),
              TaskCard(
                isChecked: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
