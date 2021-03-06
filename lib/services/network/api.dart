import 'dart:convert';

import 'package:lamborghini/model/cars_response.dart';
import 'package:http/http.dart' as http;
import 'package:lamborghini/model/category.dart';
import 'package:lamborghini/model/merch_response.dart';
import 'package:lamborghini/model/parent_response.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:lamborghini/model/transaction.dart';
import 'package:lamborghini/model/user.dart';
import 'package:lamborghini/services/constants/api_constants.dart';
import 'package:lamborghini/services/shared_preferences.dart';

abstract class ApiBase {
  Future<ParentResponse> getParentCategories();

  Future<CarResponse> getCars();

  Future<Category> getMerchCategories();

  Future<MerchResponse> getMerchItems();

  Future<SimpleResponse> purchaseMerchItem(Transaction transaction);

  Future<User?> getCustomer();

  Future<List<Transaction>> getTransactions();

  Future<SimpleResponse> purchasePoints(Transaction transaction);
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
        final MerchResponse merchResponse =
            MerchResponse.fromJson(response.body.toString());
        return merchResponse;
      } catch (e) {
        return MerchResponse(merchItemList: []);
      }
    } else {
      return MerchResponse(merchItemList: []);
    }
  }

  @override
  Future<SimpleResponse> purchaseMerchItem(Transaction transaction) async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}${ApiConstants.purchaseItems}"),
      headers: {"Authorization": basicAuth, "Content-Type": "application/json"},
      body: jsonEncode({
        "itemName": transaction.itemName,
        "customer": transaction.customer,
        "points": transaction.points.toString(),
        "transactionType": transaction.transactionType,
        "transactionDate": transaction.transactionDate
      }),
    );

    if (response.statusCode == 200) {
      try {
        final SimpleResponse simpleResponse =
            SimpleResponse.fromJson(jsonDecode(response.body.toString()));
        return simpleResponse;
      } catch (e) {
        final SimpleResponse simpleResponse = SimpleResponse(
          isSuccessful: false,
          message: "Something went wrong",
        );
        return simpleResponse;
      }
    } else {
      final SimpleResponse simpleResponse = SimpleResponse(
        isSuccessful: false,
        message: "Something went wrong",
      );
      return simpleResponse;
    }
  }

  @override
  Future<User?> getCustomer() async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getCustomer}"),
        headers: {
          "Authorization": basicAuth,
        });

    if (response.statusCode == 200) {
      try {
        final User user = User.fromJson(jsonDecode(response.body.toString()));
        return user;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}${ApiConstants.getTransactions}"),
        headers: {
          "Authorization": basicAuth,
        });

    if (response.statusCode == 200) {
      try {
        String jsonData = response.body.toString();

        final List<Transaction> transactions = List<Transaction>.from(
            jsonDecode(jsonData)
                .map((transaction) => Transaction.fromJson(transaction)));
        return transactions;
      } catch (e) {
        return <Transaction>[];
      }
    } else {
      return <Transaction>[];
    }
  }

  @override
  Future<SimpleResponse> purchasePoints(Transaction transaction) async {
    String username = await SharedPrefs.getStringSharedPreference("mobile");
    String password = await SharedPrefs.getStringSharedPreference("password");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}${ApiConstants.purchasePoints}"),
      headers: {
        "Authorization": basicAuth,
      },
      body: jsonEncode({
        "itemName": transaction.itemName,
        "customer": transaction.customer,
        "points": transaction.points.toString(),
        "transactionType": transaction.transactionType,
        "transactionDate": transaction.transactionDate
      }),
    );

    if (response.statusCode == 200) {
      try {
        SimpleResponse simpleResponse =
            SimpleResponse.fromJson(jsonDecode(response.body.toString()));
        return simpleResponse;
      } catch (e) {
        return SimpleResponse(
            isSuccessful: false, message: "Something went wrong");
      }
    } else {
      return SimpleResponse(
          isSuccessful: false, message: "Something went wrong");
    }
  }
}
