import 'package:car_on_sale_challenge/base/api_request.dart';

class VINRequest extends APIRequest {
  final String vin;
  VINRequest(this.vin);
  @override
  String get endpoint => 'vinEndpoint';

  @override
  Map<String, String> get parameters => {'vin': vin};
}
