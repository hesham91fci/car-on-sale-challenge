import 'package:car_on_sale_challenge/base/bloc/bloc_base_api_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/constants/app_colors.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/ui_models/vehicle_feedback_ui_model.dart';
import 'package:flutter/material.dart';

class VehicleFeedbackState extends BlocBaseApiState {
  final VehicleFeedbackUiModel _vehicleFeedbackUiModel;

  VehicleFeedbackState({required VehicleFeedbackUiModel vehicleFeedbackUiModel})
    : _vehicleFeedbackUiModel = vehicleFeedbackUiModel;

  @override
  Widget getBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _vehicleFeedbackUiModel.isPositiveFeedback
                  ? Icons.check
                  : Icons.close,
              color:
                  _vehicleFeedbackUiModel.isPositiveFeedback
                      ? greenColor
                      : redColor,
            ),
            Column(
              children: [
                Text(_vehicleFeedbackUiModel.make),
                Text(_vehicleFeedbackUiModel.model),
                Text(_vehicleFeedbackUiModel.price),
                Text(_vehicleFeedbackUiModel.feedback),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
