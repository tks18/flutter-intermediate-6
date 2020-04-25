import 'package:flutter/material.dart';
import 'package:quizzler/quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'A Quiz by Shan.tk',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> scorekeeper = [];

  Quiz quizs = Quiz();

  void checkans(bool useranswer) {    
    bool correct = quizs.quesans();
    if (useranswer == correct) {
      setState(() {
        scorekeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          )
        );
      });
    } else {
      setState(() {
        scorekeeper.add(
          Icon(
            Icons.highlight_off,
            color: Colors.red
          )
        );
      });
    }
  }
  void popup(){
    if (quizs.quesnum() < quizs.quesmax() - 1){
      setState(() {
        quizs.quesnumber();
      });
    } else {
        Alert(
          context: context,
          title: 'Finished',
          desc: 'You Have Finished Your Quiz',
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  quizs.reset();
                  scorekeeper.clear();
                });
              },
              child: Text(
                'Reset'
              )
            )
          ]
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizs.questext(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkans(true);
                popup();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkans(false);
                popup();
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
