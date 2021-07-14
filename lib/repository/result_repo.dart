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
    result.playedAt = DateTime.now().toLocal().toString().substring(0, 16);

    await this._resultData.saveResult(result);
    this.resetResult();
  }

  Future<void> loadResults() async {
    await this._resultData.loadAllResults().then((value) {
      value.docs.forEach((element) {
        var result = element.data() as Result;
        this.results.add(result);
      });
    });
  }

  Future<Result?> getResultFrom(String username) async {
    var snapshot = await this._resultData.retrieveResultFrom(username);
    if (snapshot.exists) {
      Map<String, dynamic> dataJson = snapshot.data() as Map<String, dynamic>;
      return new Result.fromJson(dataJson);
    }
    return null;
  }
}
