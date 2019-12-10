import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';

class TextFieldDefault extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final int maxLines;
  final bool enabled;

  TextFieldDefault({
    this.controller,
    this.hint,
    this.obscureText = false,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(15)),
          borderSide: BorderSide(
            color: accentColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(15)),
          borderSide: BorderSide(color: primaryGreenColor, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(15)),
          borderSide: BorderSide(color: grayColor, width: 1.0),
        ),
        hintText: hint,
      ),
    );
  }
}
