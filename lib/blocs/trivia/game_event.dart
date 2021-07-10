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

// class CalculateResultEvent extends GameEvent {}

// class RetrieveResultEvent extends GameEvent {
//   final Result result;

//   RetrieveResultEvent(this.result);

//   @override
//   List<Object?> get props => [this.result];
// }
