import 'package:comic_quiz/models/option.dart';

class Question {
  late String characterImage;
  late String question;
  late List<Option> options;

  Question(
      {required this.characterImage,
      required this.question,
      required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      var jsonOptions = json['options'] as List;
      List<Option> _opts = jsonOptions.map((e) => Option.fromJson(e)).toList();

      return new Question(
          characterImage: json['characterImage'] as String,
          question: json['question'] as String,
          options: _opts);
    }

    return new Question(
        characterImage: json['characterImage'] as String,
        question: json['question'] as String,
        options: []);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'characterImage': this.characterImage,
  //     'question': this.question,
  //     'options': (this.options).cast<Map<String, dynamic>>()
  //   };
  // }

  @override
  String toString() {
    return 'Question {${this.characterImage}, ${this.question}, ${this.options}}';
  }
}
