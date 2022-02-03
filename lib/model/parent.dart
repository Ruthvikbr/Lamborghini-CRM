class Parent {
  Parent({
    required this.parentModelName,
    required this.imageUrl,
    required this.id,
  });

  final String parentModelName;
  final String imageUrl;
  final String id;

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      parentModelName: json["parentModelName"],
      imageUrl: json["imageUrl"],
      id: json["id"],
    );
  }
}
