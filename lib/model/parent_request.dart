import 'package:lamborghini/model/parent_response.dart';

class ParentRequest {
  ParentRequest({
    this.loading = false,
    required this.parentResponse,
  });

  final bool loading;
  final ParentResponse parentResponse;

  ParentRequest copyWith({
    bool? loading,
    ParentResponse? parentResponse,
  }) {
    return ParentRequest(
      loading: loading ?? this.loading,
      parentResponse: parentResponse ?? this.parentResponse,
    );
  }
}
