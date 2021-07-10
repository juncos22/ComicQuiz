import 'dart:math';

import 'package:comic_quiz/data/trivia_data.dart';
import 'package:comic_quiz/models/option.dart';
import 'package:comic_quiz/models/question.dart';
import 'package:comic_quiz/models/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TriviaRepo {
  final TriviaData _triviaData = new TriviaData();
  List<Question> questions = [];
  List<Question> _answeredQuestions = [];
  Result? result;
  late int _qIndex;

  Future<void> loadQuestions() async {
    if (this.questions.isEmpty) {
      this.questions = await this._triviaData.loadQuestions();
    }
  }

  Question? getQuestion() {
    _qIndex = new Random().nextInt(this.questions.length);
    var question = this.questions[_qIndex];

    while (_answeredQuestions.contains(question)) {
      _qIndex = new Random().nextInt(this.questions.length);
      question = this.questions[_qIndex];
      if (_answeredQuestions.length == questions.length) {
        return null;
      }
    }

    if (!_answeredQuestions.contains(question)) {
      _answeredQuestions.add(question);
    }

    return question;
  }

  void calculateResult(Option option) {
    if (this.result == null) {
      this.result = new Result();
    }
    if (option.isAnswer) {
      this.result?.score += ((10 / this.questions.length * 0.1) * 100).round();
    }
  }

  // TODO: Averiguar por que no se resetean los valores
  void resetResult() {
    this.result = null;
    this._answeredQuestions.clear();
    this._answeredQuestions = [];
  }

  Future<void> saveResultFrom(User? user) async {
    try {
      this.result?.playedAt = DateTime.now();
      this.result?.username = user!.email!;

      await this._triviaData.saveResultFrom(this.result!);
    } on Exception catch (e) {
      print(e);
    }
  }
}
