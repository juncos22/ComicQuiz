import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountData {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> createUser(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
    var googleUser = await GoogleSignIn().signIn();
    var googleAuth = await googleUser?.authentication;
    var googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    return await this._auth.signInWithCredential(googleCredential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getUser() {
    return this._auth.currentUser;
  }
}
