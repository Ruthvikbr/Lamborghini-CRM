import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:lamborghini/model/transaction.dart';
import 'package:lamborghini/model/user.dart';
import 'package:lamborghini/services/network/api.dart';

class HomeBloc {
  final ApiBase apiBase;

  HomeBloc({required this.apiBase}) {
    getCustomer();
    getTransactions();
  }

  final StreamController<User> _userStreamController = StreamController();

  Stream<User> get userStream => _userStreamController.stream;

  void _setUser(User user) {
    _userStreamController.add(user);
  }

  final StreamController<List<Transaction>> _transactionStreamController =
      StreamController();

  Stream<List<Transaction>> get transactionStream =>
      _transactionStreamController.stream;

  void _setTransaction(List<Transaction> transactions) {
    _transactionStreamController.add(transactions);
  }

  Future<void> getCustomer() async {
    try {
      User? user = await apiBase.getCustomer();
      if (user != null) {
        _setUser(user);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTransactions() async {
    try {
      List<Transaction> transactions = await apiBase.getTransactions();
      _setTransaction(transactions);
    } catch (e) {
      debugPrint(e.toString());
      _setTransaction(<Transaction>[]);
    }
  }

  Future<SimpleResponse> purchasePoints(Transaction transaction) async {
    try {
      SimpleResponse simpleResponse = await apiBase.purchasePoints(transaction);
      getCustomer();
      return simpleResponse;
    } catch (e) {
      return SimpleResponse(
          isSuccessful: false, message: "Something went wrong");
    }
  }

  void dispose() {
    _userStreamController.close();
    _transactionStreamController.close();
  }
}
