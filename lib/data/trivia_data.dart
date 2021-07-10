import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_quiz/models/question.dart';
import 'package:comic_quiz/models/result.dart';

class TriviaData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Question> _questions = [];

  Future<List<Question>> loadQuestions() async {
    var querySnapshot = await this._firestore.collection('questions').get();
    this._questions =
        querySnapshot.docs.map((e) => Question.fromJson(e.data())).toList();
    return this._questions;
  }

  Future<void> saveResultFrom(Result result) async {
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
    return await this._firestore.doc(username).get();
  }
}
