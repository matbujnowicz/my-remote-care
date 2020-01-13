import 'package:flutter/material.dart';

enum QuestionType {
  Text,
  Radio,
}

class QuestionModel {
  QuestionType questionType;
  String question;
  dynamic answer;

  QuestionModel(
      {@required this.questionType, @required this.question, this.answer});
}
