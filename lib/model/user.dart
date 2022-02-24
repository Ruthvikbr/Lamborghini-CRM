class User {
  final String mobile;
  final double points;

  User({required this.mobile, required this.points});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      mobile: json["mobile"],
      points: json["points"],
    );
  }
}
