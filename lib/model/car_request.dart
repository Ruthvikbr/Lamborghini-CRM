import 'package:lamborghini/model/cars_response.dart';

class CarRequest {
  CarRequest({
    required this.loading,
    required this.carResponse,
  });

  final bool loading;
  final CarResponse carResponse;

  CarRequest copyWith({
    bool? loading,
    CarResponse? carResponse,
  }) {
    return CarRequest(
      loading: loading ?? this.loading,
      carResponse: carResponse ?? this.carResponse,
    );
  }
}
