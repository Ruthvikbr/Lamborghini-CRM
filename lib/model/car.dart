import 'package:flutter/cupertino.dart';

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

  factory Car.fromJson(Map<String, dynamic> data) {
    debugPrint(data.toString());
    return Car(
      modelName: data["modelName"],
      parentModelName: data["parentModelName"],
      power: data["power"],
      maxSpeed: data["maxSpeed"],
      zeroToHundredAcceleration: data["zeroToHundredAcceleration"],
      overview: data["overview"],
      imageUrl: data["imageUrl"],
      id: data["id"],
    );
  }
}
