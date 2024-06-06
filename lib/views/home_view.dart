import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/themes/app_color.dart';
import 'package:task_app/widgets/create_task_button.dart';
import 'package:task_app/widgets/create_task_desktop.dart';
import 'package:task_app/widgets/nav_bar.dart';
import '../shared/BloC/task_cubit.dart';
import '../shared/BloC/task_states.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _getFAB(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good Morning',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'inter'),
                      ),
                      const SizedBox(height: 16),
                      NavBar(),
                      Platform.isWindows
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Center(
                                child: CreateTaskButton(),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

//get floating action button on condition of platform type
  Widget _getFAB() {
    if (Platform.isWindows) {
      return const FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: null,
          child: DesktopTaskButton());
    } else {
      return Container();
    }
  }
}
