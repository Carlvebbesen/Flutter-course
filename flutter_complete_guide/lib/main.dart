import "package:flutter/material.dart";
import 'package:flutter_complete_guide/quiz.dart';
import 'package:flutter_complete_guide/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      "questionText": "Hva er din favorittfarge?",
      "answers": [
        {"text": "blå", "score": 5},
        {"text": "hvit", "score": 3},
      ]
    },
    {
      "questionText": "Hva er din favorittbil?",
      "answers": [
        {"text": "bmv", "score": 2},
        {"text": "skoda", "score": 1},
        {"text": "tesla", "score": 5},
        {"text": "opel", "score": 6},
      ]
    },
    {
      "questionText": "Hva er din favorittrett?",
      "answers": [
        {"text": "burger", "score": 3},
        {"text": "taco", "score": 2},
        {"text": "fisk", "score": 5},
        {"text": "pasta", "score": 4},
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerFunc(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("My First App"),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  questionIndex: _questionIndex,
                  questions: _questions,
                  answerFunc: _answerFunc,
                )
              : Result(_totalScore, _resetQuiz)),
    );
  }
}
