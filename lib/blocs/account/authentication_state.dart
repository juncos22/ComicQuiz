part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AccountStateChanged extends AuthenticationState {
  final User? user;
  final AccountRepo accountRepo;

  AccountStateChanged(this.accountRepo) : this.user = accountRepo.user;

  @override
  List<Object?> get props => [this.user];
}

class LoggingInState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class LogoutSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class LoginFailureState extends AuthenticationState {
  final String error;

  LoginFailureState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class LogoutFailureState extends AuthenticationState {
  final String error;

  LogoutFailureState(this.error);

  @override
  List<Object?> get props => [this.error];
}
