import 'dart:convert';

import 'package:lamborghini/model/account_request.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:http/http.dart' as http;
import 'package:lamborghini/services/constants/api_constants.dart';
import 'package:lamborghini/services/shared_preferences.dart';

abstract class AuthBase {
  Future<SimpleResponse> accountRequest(
      AccountRequest accountRequest, String accountRequestType);
}

class Auth implements AuthBase {
  @override
  Future<SimpleResponse> accountRequest(
    AccountRequest accountRequest,
    String accountRequestType,
  ) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}$accountRequestType"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'mobile': accountRequest.mobile,
        'password': accountRequest.password
      }),
    );

    if (response.statusCode == 200) {
      try {
        final SimpleResponse simpleResponse =
            SimpleResponse.fromJson(jsonDecode(response.body.toString()));
        await SharedPrefs.setStringSharedPreference(
            "mobile", accountRequest.mobile);
        await SharedPrefs.setStringSharedPreference(
            "password", accountRequest.password);
        await SharedPrefs.setBooleanSharedPreference("isLoggedIn", true);
        return simpleResponse;
      } catch (e) {
        final SimpleResponse simpleResponse = SimpleResponse(
          isSuccessful: false,
          message: "Something went wrong",
        );
        await SharedPrefs.setStringSharedPreference("mobile", "");
        await SharedPrefs.setStringSharedPreference("password", "");
        await SharedPrefs.setBooleanSharedPreference("isLoggedIn", false);
        return simpleResponse;
      }
    } else {
      final SimpleResponse simpleResponse = SimpleResponse(
        isSuccessful: false,
        message: "Something went wrong",
      );
      await SharedPrefs.setStringSharedPreference("mobile", "");
      await SharedPrefs.setStringSharedPreference("password", "");
      await SharedPrefs.setBooleanSharedPreference("isLoggedIn", false);
      return simpleResponse;
    }
  }

  Future<void> logout() async {
    await SharedPrefs.setStringSharedPreference("mobile", "");
    await SharedPrefs.setStringSharedPreference("password", "");
    await SharedPrefs.setBooleanSharedPreference("isLoggedIn", false);
  }
}
