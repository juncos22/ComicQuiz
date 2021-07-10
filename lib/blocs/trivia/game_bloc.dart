import 'package:comic_quiz/repository/account_repo.dart';
import 'package:comic_quiz/repository/trivia_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_quiz/models/option.dart';
import 'package:comic_quiz/models/result.dart';
import 'package:equatable/equatable.dart';
import 'package:comic_quiz/models/question.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBLoC extends Bloc<GameEvent, GameState> {
  GameBLoC(this._triviaRepo, this._accountRepo) : super(GameStartedState());

  final TriviaRepo _triviaRepo;
  final AccountRepo _accountRepo;

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
          await this._triviaRepo.saveResultFrom(this._accountRepo.user);
          yield GameFinishedState(this._triviaRepo.result!);
        }
      } catch (e) {
        yield GameFailureState(e.toString());
      }
    }
    if (event is AnswerQuestionEvent) {
      try {
        this._triviaRepo.calculateResult(event.option);
        yield QuestionAnsweredState();
      } catch (e) {
        yield GameFailureState(e.toString());
      }
    }
  }
}
