import 'dart:math';

import 'package:comic_quiz/data/trivia_data.dart';
import 'package:comic_quiz/models/question.dart';

class TriviaRepo {
  final TriviaData _triviaData;
  List<Question> questions = [];
  final List<Question> _answeredQuestions = [];
  late int _qIndex;

  TriviaRepo(this._triviaData);

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

  void cleanAnsweredQuestions() {
    if (this._answeredQuestions.isNotEmpty) {
      this._answeredQuestions.clear();
    }
  }
}
