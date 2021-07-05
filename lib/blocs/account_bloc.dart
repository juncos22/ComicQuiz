import 'dart:async';

import 'package:comic_quiz/blocs/events/account_event.dart';
import 'package:comic_quiz/blocs/states/account_state.dart';
import 'package:comic_quiz/repository/account_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  StreamController<AccountEvent> _accountEvent = new StreamController();
  StreamController<AccountState> _accountState = new StreamController();
  final AccountRepo _accountRepo = AccountRepo();

  Stream<AccountState> get accountState => this._accountState.stream;
  StreamSink<AccountEvent> get accountEvent => this._accountEvent.sink;

  AccountBloc() : super(UnAuthenticatedState()) {
    _accountEvent.stream.listen(mapEventToState);
  }

  void dispose() {
    this._accountEvent.close();
    this._accountState.close();
  }

  Future<User?> _mapLogin(String email, String password) async {
    return await this._accountRepo.login(email, password);
  }

  Future<void> _mapLogout() async {
    await this._accountRepo.logout();
  }

  Future<User?> _mapSignUp(String email, String password) async {
    return await this._accountRepo.signUp(email, password);
  }

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is SignUpEvent) {
      this._accountState.add(LoadingState());
      try {
        var user = await this._mapSignUp(event.email, event.password);
        this._accountState.add(AuthenticatedState(user));
      } catch (e) {
        this._accountState.addError(e);
      }
    } else if (event is LoginEvent) {
      this._accountState.add(LoadingState());
      try {
        var user = await this._mapLogin(event.email, event.password);
        this._accountState.add(AuthenticatedState(user));
      } catch (e) {
        this._accountState.addError(e);
      }
    } else {
      this._accountState.add(LoadingState());
      try {
        await this._mapLogout();
        this._accountState.add(UnAuthenticatedState());
      } catch (e) {
        this._accountState.addError(e);
      }
    }
  }
}
