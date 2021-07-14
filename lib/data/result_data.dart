import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_quiz/models/result.dart';

class ResultData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveResult(Result result) async {
    await this._firestore.collection('results').doc(result.username).set({
      'username': result.username,
      'score': result.score,
      'playedAt': result.playedAt
    });
  }

  Future<QuerySnapshot> loadAllResults() async {
    return await this._firestore.collection('results').get();
  }

  Future<DocumentSnapshot> retrieveResultFrom(String username) async {
    return await this._firestore.collection('results').doc(username).get();
  }
}
