import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comic_quiz/repository/account_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(UnauthenticatedState());

  final AccountRepo _accountRepo = new AccountRepo();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    try {
      yield LoadingState();
      if (event is LoginEvent) {
        var user = await this._accountRepo.login(event.email, event.password);
        if (user != null) {
          yield AuthenticatedState(user);
        } else {
          yield Failure("Usuario o contraseña incorrectos");
        }
      } else if (event is SignUpEvent) {
        var user = await this._accountRepo.signUp(event.email, event.password);
        if (user != null) {
          yield AuthenticatedState(user);
        } else {
          yield Failure("No se pudo crear la cuenta");
        }
      } else if (event is LogoutEvent) {
        await this._accountRepo.logout();
        yield UnauthenticatedState();
      }
    } on Exception catch (e) {
      yield Failure(e);
    }
  }
}
