class Option {
  late String option;
  late bool isAnswer;

  Option({required this.option, required this.isAnswer});

  factory Option.fromJson(dynamic json) {
    return new Option(
        option: json['option'] as String, isAnswer: json['isAnswer'] as bool);
  }

  @override
  String toString() {
    return "Option {${this.option}, ${this.isAnswer}}";
  }
}
