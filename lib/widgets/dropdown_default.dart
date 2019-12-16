import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';

class DropdownDefault<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Function onChanged;

  DropdownDefault({this.items, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(15)),
          border: Border.all(color: primaryGreenColor, width: 1.0)),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          child: DropdownButton<T>(
            items: items,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
