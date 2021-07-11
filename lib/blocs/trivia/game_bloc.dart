import 'package:comic_quiz/repository/account_repo.dart';
import 'package:comic_quiz/repository/result_repo.dart';
import 'package:comic_quiz/repository/trivia_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_quiz/models/option.dart';
import 'package:comic_quiz/models/result.dart';
import 'package:equatable/equatable.dart';
import 'package:comic_quiz/models/question.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBLoC extends Bloc<GameEvent, GameState> {
  GameBLoC(this._triviaRepo, this._accountRepo, this._resultRepo)
      : super(GameStartedState());

  final TriviaRepo _triviaRepo;
  final AccountRepo _accountRepo;
  final ResultRepo _resultRepo;

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is LoadQuestionsEvent) {
      yield LoadingQuestionState();

      try {
        await this._triviaRepo.loadQuestions();
        var question = this._triviaRepo.getQuestion();

        if (question != null) {
          yield QuestionLoadedState(question);
        } else {
          var result = new Result();
          var username = this._accountRepo.user!.displayName!.isNotEmpty
              ? this._accountRepo.user?.displayName!
              : this._accountRepo.user?.email!;

          result.username = username!;
          result.score = this._resultRepo.score;

          await this._resultRepo.saveResult(result);
          this._resultRepo.resetResult();
          this._triviaRepo.cleanAnsweredQuestions();
          yield GameFinishedState(result);
        }
      } catch (e) {
        yield GameFailureState(e.toString());
      }
    }
    if (event is AnswerQuestionEvent) {
      try {
        this
            ._resultRepo
            .calculateResult(event.option, this._triviaRepo.questions.length);
        yield QuestionAnsweredState();
      } catch (e) {
        yield GameFailureState(e.toString());
      }
    }
  }
}
