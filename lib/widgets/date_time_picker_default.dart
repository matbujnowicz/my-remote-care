import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mrc/app/styles.dart';

class DateTimePickerDefault extends StatelessWidget {
  final Function onDatePicked;
  final DateTime valueDate;

  DateTimePickerDefault({this.onDatePicked, this.valueDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(15)),
            border: Border.all(color: primaryGreenColor, width: 1.0)),
        width: double.infinity,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        child: Text(getFormattedDate()),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    DatePicker.showDateTimePicker(context,
        currentTime: DateTime.now(), onChanged: onDatePicked);
  }

  String getFormattedDate() {
    if (valueDate == null) return "";
    final format = DateFormat('dd.MM HH:mm');
    return format.format(valueDate);
  }
}
