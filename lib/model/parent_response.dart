import 'dart:convert';

import 'package:lamborghini/model/parent.dart';

class ParentResponse {
  final List<Parent> parentList;

  ParentResponse({required this.parentList});

  factory ParentResponse.fromJson(String data) {
    return ParentResponse(
      parentList: List<Parent>.from(
          json.decode(data).map((item) => Parent.fromJson(item))),
    );
  }
}
