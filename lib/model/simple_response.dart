class SimpleResponse {
  SimpleResponse({required this.isSuccessful, required this.message});

  final bool isSuccessful;
  final String message;

  factory SimpleResponse.fromJson(Map<String, dynamic> json) {
    return SimpleResponse(
      isSuccessful: json["isSuccessful"],
      message: json["message"],
    );
  }
}
