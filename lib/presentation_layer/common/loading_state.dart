import 'package:car_on_sale_challenge/base/bloc/bloc_base_api_state.dart';
import 'package:flutter/material.dart';

class LoadingState extends BlocBaseApiState {
  @override
  Widget getBody(BuildContext context) => CircularProgressIndicator();
}
