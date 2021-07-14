class Result {
  late String username;
  late int score;
  late String playedAt;

  Result._(this.username, this.score, this.playedAt);

  Result() {
    this.score = 0;
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return new Result._(json["username"], json["score"], json["playedAt"]);
  }

  @override
  String toString() {
    return "Result {$username, $score, $playedAt}";
  }
}
