import 'package:car_on_sale_challenge/base/bloc/bloc_base_api_state.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/common/error_model.dart';
import 'package:flutter/material.dart';

class ErrorState extends BlocBaseApiState {
  final ErrorModel errorModel;
  final VoidCallback retryHandler;
  ErrorState(this.errorModel, {required this.retryHandler});
  @override
  Widget getBody(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errorModel.message ?? ''),
        ElevatedButton(onPressed: retryHandler, child: Text('Retry')),
      ],
    );
  }
}
