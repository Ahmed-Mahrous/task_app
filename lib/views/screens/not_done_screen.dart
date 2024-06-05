import 'package:flutter/material.dart';
import 'package:task_app/widgets/create_task_button.dart';
import '../../widgets/task_card.dart';

class NotDoneScreen extends StatefulWidget {
  const NotDoneScreen({Key? key}) : super(key: key);

  @override
  State<NotDoneScreen> createState() => _NotDoneScreenState();
}

class _NotDoneScreenState extends State<NotDoneScreen> {
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
