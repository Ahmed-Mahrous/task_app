import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/widgets/create_task_button.dart';
import '../../shared/BloC/task_cubit.dart';
import '../../shared/BloC/task_states.dart';
import '../../themes/app_color.dart';
import '../../widgets/task_card.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  CollectionReference done_tasks =
      FirebaseFirestore.instance.collection('done_tasks');
  @override
  @override
  Widget build(BuildContext context) {
    var taskCubit = BlocProvider.of<TaskCubit>(context);
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return FutureBuilder<QuerySnapshot>(
            future: done_tasks.get(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: Text(
                        'No tasks yet',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  TaskCard(
                                    //isChecked: true,
                                    checkColor: AppColors.primary,
                                    docId: snapshot.data!.docs[index].id,
                                    task_title: snapshot.data!.docs[index]
                                        ['task_title'],
                                    task_date: snapshot.data!.docs[index]
                                        ['task_date'],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
            });
      },
    );
  }
}
