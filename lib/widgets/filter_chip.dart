import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/shared/BloC/task_cubit.dart';

import '../shared/BloC/task_states.dart';
import '../themes/app_color.dart';
import '../views/home_view.dart';

class FilterChipItem extends StatelessWidget {
  final String title;
  final Widget pageRouteName;
  bool isSelected = false;

  FilterChipItem({
    super.key,
    required this.title,
    required this.pageRouteName,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return FilterChip(
          label: Text(title,
              style: TextStyle(color: AppColors.primary, fontSize: 18)),
          selected: isSelected,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: BorderSide.none,
          showCheckmark: false,
          labelPadding: EdgeInsets.only(left: 20, right: 20),
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.secondary,
          onSelected: (bool value) {
            isSelected = value;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => pageRouteName));
          },
        );
      },
    );
  }
}
