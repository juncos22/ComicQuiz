part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  RequestLoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [this.email, this.password];
}

class RequestLoginWithGoogle extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class RequestRegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;

  RequestRegisterEvent(this.email, this.password);

  @override
  List<Object?> get props => [this.email, this.password];
}

class RequestLogoutEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
