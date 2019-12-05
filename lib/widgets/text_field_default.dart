import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';

class TextFieldDefault extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  TextFieldDefault({this.controller, this.hint, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(15)),
          borderSide: BorderSide(
            color: primaryGreenColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(15)),
          borderSide: BorderSide(color: grayColor, width: 1.0),
        ),
        hintText: hint,
      ),
    );
  }
}
