// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class CustomCupertinoDatePicker extends StatelessWidget {
  final Function(DateTime) onDateTimeChanged;
  DateTime initDate;

  CustomCupertinoDatePicker({
    Key? key,
    required this.onDateTimeChanged,
    required this.initDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        minimumYear: 1930,
        initialDateTime: initDate,
        onDateTimeChanged: onDateTimeChanged,
        mode: CupertinoDatePickerMode.date,
        dateOrder: DatePickerDateOrder.ymd,
      ),
    );
  }
}
