import 'dart:async';

import 'package:lamborghini/model/car_request.dart';
import 'package:lamborghini/model/parent_request.dart';
import 'package:lamborghini/model/parent_response.dart';
import 'package:lamborghini/services/network/api.dart';

class InfoBloc {
  final ApiBase apiBase;

  InfoBloc({required this.apiBase});

  final StreamController<ParentRequest> _parentStreamController = StreamController();

  Stream<ParentRequest> get parentRequestStream => _parentStreamController.stream;

  final StreamController<CarRequest> _carStreamController = StreamController();

  Stream<CarRequest> get carRequestStream => _carStreamController.stream;

  ParentRequest _parentRequest = ParentRequest(
    parentResponse: ParentResponse(
      parentList: [],
    ),
  );


  void dispose() {
    _parentStreamController.close();
    _carStreamController.close();
  }

  Future<ParentResponse> getParentCategories() async {
    updateParent(loading: true);
    try {
      ParentResponse parentResponse = await apiBase.getParentCategories();
      updateParent(loading: false, parentResponse: parentResponse);
      return parentResponse;
    } catch (e) {
      updateParent(loading: false);
      return ParentResponse(parentList: []);
    }
  }

  void updateParent({
    bool? loading,
    ParentResponse? parentResponse,
  }) {
    _parentRequest = _parentRequest.copyWith(
      loading: loading,
      parentResponse: parentResponse,
    );
    _parentStreamController.add(_parentRequest);
  }
}
