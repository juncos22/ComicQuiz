class AccountEvent {}

class LoginEvent extends AccountEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class LogoutEvent extends AccountEvent {}

class SignUpEvent extends AccountEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
}
