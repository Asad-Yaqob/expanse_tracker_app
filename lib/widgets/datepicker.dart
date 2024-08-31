import 'package:expanse_tracker/modal/expense.dart';
import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  MyDatePicker(
      {super.key, required this.selectedDate, required this.datePicker});

  DateTime? selectedDate;
  void Function() datePicker;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(selectedDate == null
            ? 'no date selected'
            : formatter.format(selectedDate!)),
        IconButton(
          onPressed: datePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
