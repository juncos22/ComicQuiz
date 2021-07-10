import 'package:comic_quiz/repository/account_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBLoC
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AccountRepo _accountRepo;

  AuthenticationBLoC(this._accountRepo)
      : super(AccountStateChanged(_accountRepo));

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is RequestLoginEvent) {
      try {
        yield LoggingInState();
        await this._accountRepo.login(event.email, event.password);
        yield LoginSuccessState();
      } catch (e) {
        yield LoginFailureState(e.toString());
      }
    }
    if (event is RequestRegisterEvent) {
      yield LoggingInState();
      try {
        await this._accountRepo.signUp(event.email, event.password);
        yield LoginSuccessState();
      } catch (e) {
        yield LoginFailureState(e.toString());
      }
    }
    if (event is RequestLogoutEvent) {
      try {
        await this._accountRepo.logout();
        yield LogoutSuccessState();
      } catch (e) {
        yield LogoutFailureState(e.toString());
      }
    }
  }
}
