import 'dart:async';

import 'package:lamborghini/model/car.dart';
import 'package:lamborghini/model/cars_response.dart';
import 'package:lamborghini/model/parent.dart';
import 'package:lamborghini/model/parent_response.dart';
import 'package:lamborghini/services/network/api.dart';

class InfoBloc {
  final ApiBase apiBase;

  InfoBloc({required this.apiBase}) {
    getCategories();
    getCars();
  }

  final StreamController<List<Parent>> _parentStreamController =
      StreamController();

  Stream<List<Parent>> get parentStream => _parentStreamController.stream;

  final StreamController<List<Car>> _carStreamController = StreamController();

  Stream<List<Car>> get carRequestStream => _carStreamController.stream;

  void _setCategories(List<Parent> categories) =>
      _parentStreamController.add(categories);

  void _setCars(List<Car> cars) => _carStreamController.add(cars);

  void dispose() {
    _parentStreamController.close();
    _carStreamController.close();
  }

  Future<List<Parent>> getCategories() async {
    ParentResponse parentResponse = await apiBase.getParentCategories();
    _setCategories(parentResponse.parentList);
    return parentResponse.parentList;
  }

  Future<List<Car>> getCars() async {
    CarResponse carResponse = await apiBase.getCars();
    _setCars(carResponse.carModelList);
    return carResponse.carModelList;
  }
}
