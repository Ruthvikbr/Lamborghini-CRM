import 'dart:convert';

import 'package:lamborghini/model/cars_response.dart';
import 'package:http/http.dart' as http;
import 'package:lamborghini/model/parent_response.dart';
import 'package:lamborghini/services/constants/api_constants.dart';
import 'package:lamborghini/services/shared_preferences.dart';

abstract class ApiBase {
  Future<ParentResponse> getParentCategories();
  Future<CarResponse> getCars();
}

class Api implements ApiBase {
  @override
  Future<CarResponse> getCars() async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getCars}"),
        headers: {
          "Authorization": basicAuth,
        });

    if (response.statusCode == 200) {
      try {
        final CarResponse carResponse =
            CarResponse.fromJson(response.body.toString());
        return carResponse;
      } catch (e) {
        final CarResponse carResponse = CarResponse(carModelList: []);
        return carResponse;
      }
    } else {
      final CarResponse carResponse = CarResponse(carModelList: []);
      return carResponse;
    }
  }

  @override
  Future<ParentResponse> getParentCategories() async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getParentCategories}"),
        headers: {
          "Authorization": basicAuth,
        });

    if (response.statusCode == 200) {
      try {
        final ParentResponse parentResponse =
            ParentResponse.fromJson(response.body.toString());
        return parentResponse;
      } catch (e) {
        return ParentResponse(parentList: []);
      }
    } else {
      return ParentResponse(parentList: []);
    }
  }
}
