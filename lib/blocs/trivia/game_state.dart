part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameStartedState extends GameState {
  @override
  List<Object?> get props => [];
}

class LoadingQuestionState extends GameState {
  @override
  List<Object?> get props => [];
}

class QuestionLoadedState extends GameState {
  final Question question;

  QuestionLoadedState(this.question);

  @override
  List<Object?> get props => [this.question];
}

class GameFailureState extends GameState {
  final String error;

  GameFailureState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class QuestionAnsweredState extends GameState {
  @override
  List<Object?> get props => [];
}

class GameFinishedState extends GameState {
  final Result result;

  GameFinishedState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class LoadingResultState extends GameState {
  @override
  List<Object?> get props => [];
}

class ResultLoadedState extends GameState {
  final Result? result;

  ResultLoadedState(this.result);
  @override
  List<Object?> get props => [this.result];
}
