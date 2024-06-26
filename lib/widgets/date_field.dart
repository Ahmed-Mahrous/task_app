import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/themes/app_color.dart';

String? taskDate;

class DateField extends StatefulWidget {
  const DateField({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DateField();
  }
}

class _DateField extends State<DateField> {
  TextEditingController dateInput = TextEditingController();

  _DateField();
  //text editing controller for text field

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        taskDate = value;
      },
      controller: dateInput, //editing controller of this TextField
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xfff7f7f7),
        contentPadding: const EdgeInsets.all(12),
        hintText: 'Due Date',
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)), //icon of text field
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            builder: (context, child) {
              return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary, // header background color
                      surface: Colors.white,
                      onPrimary: Colors.white, // header text color
                      onSurface: Colors.black, // body text color
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
          String formattedDate = DateFormat('E. yyyy/MM/dd').format(pickedDate);
          //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement
          dateInput.text = formattedDate; //set output date to TextField value.
        } else {}
      },
    );
  }
}
