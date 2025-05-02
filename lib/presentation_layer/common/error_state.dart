import 'package:car_on_sale_challenge/base/base_state.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/common/error_model.dart';
import 'package:flutter/material.dart';

class ErrorState extends BaseState {
  final ErrorModel errorModel;

  ErrorState(this.errorModel);
  @override
  Widget getBody(BuildContext context) => Text('ErrorState');
}
