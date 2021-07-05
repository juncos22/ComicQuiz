part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AccountEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];
}

class LogoutEvent extends AccountEvent {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends AccountEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];
}
