import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/question_model.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/screens/common/single_screen.dart';
import 'package:mrc/widgets/card_default.dart';
import 'package:mrc/widgets/primary_button.dart';
import 'package:mrc/widgets/radio_input.dart';
import 'package:mrc/widgets/report_card.dart';
import 'package:mrc/widgets/text_field_default.dart';

class ReportScreenArguments {
  final ReportModel report;
  final bool readOnly;

  ReportScreenArguments({@required this.report, this.readOnly = false});
}

class ReportScreen extends StatefulWidget {
  final ReportScreenArguments arguments;

  ReportScreen({
    @required this.arguments,
    Key key,
  }) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Question> questions;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    setState(() {
      questions = widget.arguments.report.questions;
    });
    questions.forEach((question) => controllers.add(TextEditingController()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleScreen(
      SingleScreenArguments(
        title: widget.arguments.readOnly ? "View report" : "Fill report",
        child: Container(
          width: 0.9 * screenWidth,
          child: ListView.builder(
            itemCount: widget.arguments.readOnly
                ? questions.length + 1
                : questions.length + 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0)
                return ReportCard(
                    onPress: () {}, report: widget.arguments.report);
              if (!widget.arguments.readOnly && index == questions.length + 1) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: PrimaryButton(
                    text: "Save",
                    onPressed: saveReport,
                  ),
                );
              } else {
                Question question = questions.elementAt(index - 1);
                return CardDefault(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          question.question,
                          style: greenBoldFont,
                        ),
                      ),
                      buildAnswerField(question, index - 1)
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildAnswerField(Question question, int index) {
    TextEditingController controller = controllers.elementAt(index);
    controller.text = question.answer == null ? "" : question.answer.toString();

    switch (question.questionType) {
      case QuestionType.Text:
        return TextFieldDefault(
          controller: controller,
          maxLines: 4,
          enabled: !widget.arguments.readOnly,
        );
      case QuestionType.Radio:
        return RadioInput(
          controller: controller,
          enabled: !widget.arguments.readOnly,
        );
      default:
        return Container();
    }
  }

  void saveReport() async {
    if (!allFieldsFilled()) return;
    DateTime now = DateTime.now();
    List<dynamic> answers = List();
    controllers.forEach((controller) => answers.add(controller.text));
    await Firestore.instance
        .document('reports/' + widget.arguments.report.reportId)
        .updateData({
      "submitted": true,
      "submissionDate": now,
      "answers": answers,
    });
    Navigator.pop(context);
  }

  bool allFieldsFilled() {
    bool result = true;
    controllers.forEach((controller) {
      if (controller.text == null || controller.text == "") result = false;
    });
    return result;
  }
}
