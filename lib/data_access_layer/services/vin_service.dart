import 'dart:async';
import 'dart:convert';
import 'package:car_on_sale_challenge/data_access_layer/network/backend_configuration.dart';
import 'package:car_on_sale_challenge/data_access_layer/network/network_manager.dart';
import 'package:car_on_sale_challenge/data_access_layer/requests/vin_request.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/common/error_model.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/vehicle.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/vehicle_feedback.dart';

abstract class VINServiceType {
  Future<dynamic> loadData();
}

class VINService implements VINServiceType {
  final String vin;
  VINService(this.vin);
  @override
  Future<dynamic> loadData() async {
    VINRequest vinRequest = VINRequest(vin);
    try {
      final response = await NetworkManager.httpClient.get(
        Uri.https(
          BackendConfiguration.host,
          vinRequest.endpoint,
          vinRequest.parameters,
        ),
        headers: vinRequest.headers,
      );
      switch (response.statusCode) {
        case 300:
          return List<Vehicle>.from(
            json.decode(response.body).map((x) => Vehicle.fromJson(x)),
          );
        case 200:
          return VehicleFeedback.fromJson(json.decode(response.body));
        default:
          return ErrorModel.fromJson(json.decode(response.body));
      }
    } on TimeoutException catch (_) {
      return ErrorModel(message: 'Request timed out');
    }
  }
}
