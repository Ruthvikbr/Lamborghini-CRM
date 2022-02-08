import 'dart:convert';

import 'package:lamborghini/model/cars_response.dart';
import 'package:http/http.dart' as http;
import 'package:lamborghini/model/category.dart';
import 'package:lamborghini/model/merch_response.dart';
import 'package:lamborghini/model/parent_response.dart';
import 'package:lamborghini/services/constants/api_constants.dart';
import 'package:lamborghini/services/shared_preferences.dart';

abstract class ApiBase {
  Future<ParentResponse> getParentCategories();

  Future<CarResponse> getCars();

  Future<Category> getMerchCategories();

  Future<MerchResponse> getMerchItems();
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

  @override
  Future<Category> getMerchCategories() async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getMerchCategories}"),
        headers: {
          "Authorization": basicAuth,
        });

    if (response.statusCode == 200) {
      try {
        final Category category = Category.fromMap(response.body.toString());
        return category;
      } catch (e) {
        return Category(categories: []);
      }
    } else {
      return Category(categories: []);
    }
  }

  @override
  Future<MerchResponse> getMerchItems() async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getMerchItems}"),
        headers: {
          "Authorization": basicAuth,
        });

    if (response.statusCode == 200) {
      try {
        final MerchResponse merchResponse = MerchResponse.fromJson(response.body.toString());
        return merchResponse;
      } catch (e) {
        return MerchResponse(merchItemList: []);
      }
    } else {
      return MerchResponse(merchItemList: []);
    }
  }
}
