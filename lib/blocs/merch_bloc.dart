import 'dart:async';

import 'package:lamborghini/model/category.dart';
import 'package:lamborghini/model/merch_item.dart';
import 'package:lamborghini/model/merch_response.dart';
import 'package:lamborghini/services/network/api.dart';

class MerchBloc {
  final ApiBase apiBase;

  MerchBloc({required this.apiBase}) {
    getCategories();
        getMerchItems();
  }

  final StreamController<List<MerchItem>> _merchStreamController =
      StreamController();

  final StreamController<Category> _categoryStreamController =
      StreamController();

  Stream<List<MerchItem>> get merchStream => _merchStreamController.stream;

  Stream<Category> get categoryStream => _categoryStreamController.stream;

  void _setMerchItems(List<MerchItem> merchItems) {
    _merchStreamController.add(merchItems);
  }

  void _setCategory(Category category) {
    _categoryStreamController.add(category);
  }

  void dispose() {
    _merchStreamController.close();
    _categoryStreamController.close();
  }

  Future<Category> getCategories() async {
    Category category = await apiBase.getMerchCategories();
    _setCategory(category);
    return category;
  }

  Future<void> getMerchItems() async {
    MerchResponse merchResponse = await apiBase.getMerchItems();
    List<MerchItem> merchItems = merchResponse.merchItemList;
    _setMerchItems(merchItems);
  }
}
