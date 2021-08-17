import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetQuiz;

  Result(this.resultScore, this.resetQuiz);

  String get resultPhrase {
    var resultText = "Du klarte det!";
    if (resultScore <= 8) {
      resultText = "Du er smart og uskyldig";
    }
    if (resultScore <= 12) {
      resultText = "Man kan like deg ja!";
    } else {
      resultText = "Du er dårlig!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetQuiz,
            child: Text("Restart Quiz!"),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
