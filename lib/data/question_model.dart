import 'package:flutter/material.dart';

enum QuestionType {
  Text,
  Radio,
}

class Question {
  QuestionType questionType;
  String question;
  dynamic answer;

  Question({@required this.questionType, @required this.question, this.answer});
}
