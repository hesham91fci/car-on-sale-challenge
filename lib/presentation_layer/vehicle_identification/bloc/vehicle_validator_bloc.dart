import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/event/vehicle_validation_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/state/vehicle_validator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleValidatorBloc
    extends Bloc<VehicleValidationEvent, VehicleValidatorState> {
  VehicleValidatorBloc() : super(VehicleValidatorState()) {
    on<VehicleValidationEvent>(_onVinChanged);
  }

  _onVinChanged(
    VehicleValidationEvent event,
    Emitter<VehicleValidatorState> emit,
  ) {
    emit(_validate(state.copyWith(vin: event.vin)));
  }

  VehicleValidatorState _validate(VehicleValidatorState state) {
    final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$', caseSensitive: false);
    String? vinError;
    if (state.vin.trim().isEmpty) {
      vinError = 'VIN cannot be empty';
    } else if (!vinRegex.hasMatch(state.vin)) {
      vinError =
          'VIN should be 17 characters avoiding (i, o, q) lower or upper cases ';
    }
    final isValid = vinError == null;
    return state.copyWith(vinError: vinError, isValid: isValid);
  }
}
