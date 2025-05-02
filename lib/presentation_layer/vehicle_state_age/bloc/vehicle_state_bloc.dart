import 'package:car_on_sale_challenge/base/base_state.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/common/error_model.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/vehicle_feedback.dart';
import 'package:car_on_sale_challenge/data_access_layer/services/vin_service.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/error_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/loading_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/event/vehicle_state_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/states/vehicle_feedback_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/states/vehicle_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleStateBloc extends Bloc<VehicleStateEvent, BaseState> {
  VehicleStateBloc({required VINServiceType vinService})
    : super(LoadingState()) {
    on<VehicleStateEvent>((event, emit) async {
      emit(LoadingState());
      final response = await vinService.loadData();
      if (response is ErrorModel) {
        emit(ErrorState(response));
      } else if (response is VehicleFeedback) {
        emit(VehicleFeedbackState());
      } else {
        emit(VehicleSelectionState());
      }
    });
  }
}
