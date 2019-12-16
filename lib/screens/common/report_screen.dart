import 'package:flutter/material.dart';
import 'package:mrc/app/styles.dart';
import 'package:mrc/data/report_model.dart';
import 'package:mrc/screens/common/single_screen.dart';
import 'package:mrc/widgets/card_default.dart';
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
            itemCount: questions.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0)
                return ReportCard(
                    onPress: () {}, report: widget.arguments.report);
              else {
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
                      buildAnswerField(question)
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

  Widget buildAnswerField(Question question) {
    TextEditingController controller = TextEditingController();
    controller.text = question.answer == null ? "" : question.answer.toString();
    controllers.add(controller);

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
}
