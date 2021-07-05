import 'package:firebase_auth/firebase_auth.dart';

class AccountState {}

class UnAuthenticatedState extends AccountState {}

class AuthenticatedState extends AccountState {
  User? user;

  AuthenticatedState(this.user);
}

class FailureState extends AccountState {
  final Object error;

  FailureState(this.error);
}

class LoadingState extends AccountState {}
