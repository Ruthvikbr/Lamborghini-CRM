import 'dart:convert';

import 'package:lamborghini/model/car.dart';

class CarResponse {
  CarResponse({required this.carModelList});

  final List<Car> carModelList;

  factory CarResponse.fromJson(String data) {
    return CarResponse(
        carModelList: List<Car>.from(
            json.decode(data).map((item) => Car.fromJson(item))));
  }
}
