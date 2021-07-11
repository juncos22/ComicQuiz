import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comic_quiz/models/question.dart';

class TriviaData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Question> _questions = [];

  Future<List<Question>> loadQuestions() async {
    var querySnapshot = await this._firestore.collection('questions').get();
    this._questions =
        querySnapshot.docs.map((e) => Question.fromJson(e.data())).toList();
    return this._questions;
  }
}
