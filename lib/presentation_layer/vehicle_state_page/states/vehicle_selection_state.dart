import 'package:car_on_sale_challenge/base/bloc/bloc_base_api_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/constants/app_colors.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/ui_models/vehicle_selection_ui_model.dart';
import 'package:flutter/material.dart';

class VehicleSelectionState extends BlocBaseApiState {
  final List<VehicleSelectionUiModel> _vehicles;

  VehicleSelectionState({required List<VehicleSelectionUiModel> vehicles})
    : _vehicles = vehicles;

  @override
  Widget getBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
          itemCount: _vehicles.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final dimValue = 255 - (index * 50);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: mainColor.withAlpha(dimValue > 0 ? dimValue : 0),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text(
                      _vehicles[index].make,
                      style: TextStyle(color: whiteColor),
                    ),
                    Text(
                      _vehicles[index].model,
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Center(
          child: Text(
            'Hint: Vehicles are sorted by the mos suitable ones',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
