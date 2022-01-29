import 'dart:async';

import 'package:lamborghini/model/account_request.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:lamborghini/services/network/auth.dart';

class AccountRequestBloc {
  AccountRequestBloc({required this.authBase});

  final AuthBase authBase;

  final StreamController<AccountRequest> _streamController = StreamController.broadcast();

  Stream<AccountRequest> get accountRequestStream => _streamController.stream;

  AccountRequest _accountRequest = AccountRequest();

  void dispose() {
    _streamController.close();
  }

  Future<SimpleResponse> submit(
    AccountRequest accountRequest,
    String accountRequestType,
  ) async {
    updateWith(loading: true, submitted: true);
    try {
      SimpleResponse simpleResponse = await authBase.accountRequest(
        accountRequest,
        accountRequestType,
      );
      if (!simpleResponse.isSuccessful) {
        updateWith(loading: false);
      }
      return simpleResponse;
    } catch (e) {
      updateWith(loading: false);
      return SimpleResponse(
        isSuccessful: false,
        message: "Something went wrong",
      );
    }
  }

  void updateWith({
    String? mobile,
    String? password,
    SignInFormType? formType,
    bool? loading,
    bool? submitted,
  }) {
    _accountRequest = _accountRequest.copyWith(
      mobile: mobile,
      password: password,
      signInFormType: formType,
      loading: loading,
      submitted: submitted,
    );
    _streamController.add(_accountRequest);
  }

  void updatePassword(String? password) => updateWith(password: password);

  void updateMobile(String? mobile) => updateWith(mobile: mobile);
}
