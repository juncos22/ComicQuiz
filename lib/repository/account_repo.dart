import 'package:comic_quiz/data/account_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepo {
  final AccountData _accountData;

  AccountRepo(this._accountData);

  User? get user => this._accountData.getUser();

  Future<User?> signUp(String email, String password) async {
    var credential = await this._accountData.createUser(email, password);
    return credential.user;
  }

  Future<User?> signInGoogle() async {
    var credential = await this._accountData.signInWithGoogle();
    return credential.user;
  }

  Future<User?> login(String email, String password) async {
    var credential = await this._accountData.signIn(email, password);
    return credential.user;
  }

  Future<void> logout() async {
    await this._accountData.signOut();
  }
}
