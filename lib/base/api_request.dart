import 'dart:core';
import 'package:car_on_sale_challenge/data_access_layer/network/network_manager.dart';

enum ServerMethod { get, post, delete, put }

abstract class APIRequest {
  String get endpoint;
  Map<String, String> get parameters => {};
  Map<String, String> get headers => {NetworkManager.user: 'someUserId'};
  Map<String, dynamic> get body => {};
}
