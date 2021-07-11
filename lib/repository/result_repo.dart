import 'package:comic_quiz/data/result_data.dart';
import 'package:comic_quiz/models/option.dart';
import 'package:comic_quiz/models/result.dart';

class ResultRepo {
  final ResultData _resultData;
  final List<Result> results = [];
  int _score = 0;

  int get score => this._score;

  ResultRepo(this._resultData);

  void resetResult() {
    this._score = 0;
  }

  void calculateResult(Option option, int questionsLength) {
    if (option.isAnswer) {
      this._score += ((10 / questionsLength * 0.1) * 100).round();
    }
  }

  Future<void> saveResult(Result result) async {
    try {
      result.playedAt = DateTime.now();

      await this._resultData.saveResult(result);
      this.resetResult();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> loadResults() async {
    try {
      await this._resultData.loadAllResults().then((value) {
        value.docs.forEach((element) {
          var result = element.data() as Result;
          this.results.add(result);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Result?> getResultFrom(String username) async {
    try {
      await this._resultData.retrieveResultFrom(username).then((value) {
        var result = value.data() as Result;
        return result;
      });
    } catch (e) {
      print(e);
    }
    return null;
  }
}
