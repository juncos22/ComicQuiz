part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class UnauthenticatedState extends AccountState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AccountState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AccountState {
  final User user;

  AuthenticatedState(this.user);

  @override
  List<Object> get props => [this.user];
}

class Failure extends AccountState {
  final Object error;

  Failure(this.error);

  @override
  List<Object> get props => [this.error];
}
