import 'package:flutter/material.dart';
import 'package:task_app/widgets/create_task_button.dart';
import '../../widgets/task_card.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
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
