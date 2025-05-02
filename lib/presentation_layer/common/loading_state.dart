import 'package:car_on_sale_challenge/base/base_state.dart';
import 'package:flutter/material.dart';

class LoadingState extends BaseState {
  @override
  Widget getBody(BuildContext context) => CircularProgressIndicator();
}
