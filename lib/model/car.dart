class Car {
  final String modelName;
  final String parentModelName;
  final String power;
  final String maxSpeed;
  final String zeroToHundredAcceleration;
  final String overview;
  final String imageUrl;
  final String id;

  Car({
    required this.modelName,
    required this.parentModelName,
    required this.power,
    required this.maxSpeed,
    required this.zeroToHundredAcceleration,
    required this.overview,
    required this.imageUrl,
    required this.id,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      modelName: json["modelName"],
      parentModelName: json["parentModelName"],
      power: json["power"],
      maxSpeed: json["maxSpeed"],
      zeroToHundredAcceleration: json["zeroToHundredAcceleration"],
      overview: json["overview"],
      imageUrl: json["imageUrl"],
      id: json["id"],
    );
  }
}
