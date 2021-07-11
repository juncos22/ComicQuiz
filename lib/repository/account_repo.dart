import 'package:comic_quiz/data/account_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepo {
  final AccountData _accountData;

  AccountRepo(this._accountData);

  User? get user => this._accountData.getUser();

  Future<User?> signUp(String email, String password) async {
    try {
      var credential = await this._accountData.createUser(email, password);
      return credential.user;
    } catch (e) {
      print(e);
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      // Logica de logeo con Firebase
      var credential = await this._accountData.signIn(email, password);
      return credential.user;
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await this._accountData.signOut();
    } catch (e) {
      print(e);
    }
  }
}
