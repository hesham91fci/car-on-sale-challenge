import 'package:car_on_sale_challenge/Base/base_stateful_widget.dart';
import 'package:car_on_sale_challenge/business_layer/module_configurator.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/cos_textfield.dart';
import 'package:car_on_sale_challenge/presentation_layer/constants/app_constants.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/bloc/vehicle_validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/event/vehicle_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/state/vehicle_validator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleIdentificationPage extends BaseStatefulWidget {
  const VehicleIdentificationPage({super.key});

  @override
  BaseState<VehicleIdentificationPage> createState() =>
      _VehicleIdentificationState();
}

class _VehicleIdentificationState extends BaseState<VehicleIdentificationPage> {
  VehicleValidatorBloc? _vehicleValidatorBloc;
  final FocusNode _vinFocusNode = FocusNode();
  final TextEditingController _vinController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _vehicleValidatorBloc = BlocProvider.of<VehicleValidatorBloc>(context);
  }

  @override
  Widget getBody(BuildContext context) {
    return BlocBuilder<VehicleValidatorBloc, VehicleValidatorState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: CosTextfield(
                      label: 'Vehicle Identification Number (VIN)',
                      onChanged:
                          (value) => _vehicleValidatorBloc?.add(
                            VehicleValidationEvent(value),
                          ),
                      editingController: _vinController,
                      error: _vinFocusNode.hasFocus ? state.vinError : null,
                    ),
                  ),
                  TextButton(
                    child: Text('Generate Vin'),
                    onPressed: () {
                      _vinController.text = vehicleIdentificationNumber;
                      _vehicleValidatorBloc?.add(
                        VehicleValidationEvent(vehicleIdentificationNumber),
                      );
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed:
                    state.isValid
                        ? () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (_) => ModuleConfigurator(
                                    context,
                                  ).configureVehicleStatePage(
                                    _vinController.text,
                                  ),
                            ),
                          ),
                        }
                        : null,
                child: Text('Register Vehicle'),
              ),
            ],
          ),
        );
      },
    );
  }
}
