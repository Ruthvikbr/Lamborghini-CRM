import 'dart:convert';

import 'package:lamborghini/model/merch_item.dart';

class MerchResponse {
  MerchResponse({required this.merchItemList});

  final List<MerchItem> merchItemList;

  factory MerchResponse.fromJson(String data) {
    return MerchResponse(
      merchItemList: List<MerchItem>.from(
          json.decode(data).map((item) => MerchItem.fromJson(item))),
    );
  }
}
