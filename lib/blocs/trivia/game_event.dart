part of 'game_bloc.dart';

class GameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadQuestionsEvent extends GameEvent {
  @override
  List<Object?> get props => [];
}

class AnswerQuestionEvent extends GameEvent {
  final Option option;

  AnswerQuestionEvent(this.option);
  @override
  List<Object?> get props => [this.option];
}

class RetrieveResultEvent extends GameEvent {
  RetrieveResultEvent();

  @override
  List<Object?> get props => [];
}
