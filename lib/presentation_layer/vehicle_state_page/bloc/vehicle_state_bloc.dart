import 'dart:convert';

import 'package:car_on_sale_challenge/base/bloc/bloc_base_api_state.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/common/error_model.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/vehicle.dart';
import 'package:car_on_sale_challenge/business_layer/domain_models/vehicle_feedback.dart';
import 'package:car_on_sale_challenge/data_access_layer/local_storage/local_starage_manager.dart';
import 'package:car_on_sale_challenge/data_access_layer/local_storage/record_name.dart';
import 'package:car_on_sale_challenge/data_access_layer/services/vin_service.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/error_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/loading_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/event/vehicle_state_event.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/states/vehicle_feedback_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/states/vehicle_selection_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/ui_models/vehicle_feedback_ui_model.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/ui_models/vehicle_selection_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';

class VehicleStateBloc extends Bloc<VehicleStateEvent, BlocBaseApiState> {
  VehicleStateBloc({required VINServiceType vinService})
    : super(LoadingState()) {
    on<VehicleStateEvent>((event, emit) async {
      emit(LoadingState());
      final response = await vinService.loadData();
      if (response is ErrorModel) {
        emit(ErrorState(response, retryHandler: () => add(event)));
        await _getLastSucceededResponse(emit);
      } else if (response is VehicleFeedback) {
        await LocalStorageManager.shared.save(
          RecordName.lastSucceededResponse,
          {'type': 'feedback', 'data': response.toJson()},
        );
        _onVehicleFeedbackReceived(response, emit, event);
      } else if (response is List<Vehicle>) {
        final vehicles = json.encode(response.map((v) => v.toJson()).toList());
        await LocalStorageManager.shared.save(
          RecordName.lastSucceededResponse,
          {'type': 'vehicles', 'data': vehicles},
        );
        _onMultipleVehiclesReceived(response, emit);
      }
    });
  }

  _getLastSucceededResponse(Emitter<BlocBaseApiState> emit) async {
    final lastSucceededJson =
        await LocalStorageManager.shared.get(
          RecordName.lastSucceededResponse,
        ) ??
        {};
    if (lastSucceededJson.isEmpty) {
      return;
    }
    if (lastSucceededJson['type'] == 'vehicles') {
      final vehicles = List<Vehicle>.from(
        json.decode(lastSucceededJson['data']).map((x) => Vehicle.fromJson(x)),
      );
      emit(VehicleSelectionState(vehicles: _mapToVehiclesUiModel(vehicles)));
    } else if (lastSucceededJson['type'] == 'feedback') {
      final vehicleFeedback = VehicleFeedback.fromJson(
        lastSucceededJson['data'],
      );

      emit(
        VehicleFeedbackState(
          vehicleFeedbackUiModel: _mapToVehicleUiModel(vehicleFeedback),
        ),
      );
    }
  }

  _onMultipleVehiclesReceived(
    List<Vehicle> response,
    Emitter<BlocBaseApiState> emit,
  ) {
    response.sort((a, b) => b.similarity?.compareTo(a.similarity ?? 0) ?? 1);
    final uiVehicles = _mapToVehiclesUiModel(response);
    emit(VehicleSelectionState(vehicles: uiVehicles));
  }

  _onVehicleFeedbackReceived(
    VehicleFeedback response,
    Emitter<BlocBaseApiState> emit,
    VehicleStateEvent event,
  ) {
    final properties = [
      response.feedback,
      response.make,
      response.model,
      response.price,
      response.positiveCustomerFeedback,
    ];
    final isValidFeedback = properties.nonNulls.length == properties.length;
    if (isValidFeedback) {
      emit(
        VehicleFeedbackState(
          vehicleFeedbackUiModel: _mapToVehicleUiModel(response),
        ),
      );
    } else {
      emit(
        ErrorState(
          ErrorModel(message: 'Invalid feedback'),
          retryHandler: () => add(event),
        ),
      );
    }
  }

  List<VehicleSelectionUiModel> _mapToVehiclesUiModel(List<Vehicle> response) {
    return response
        .map((element) {
          if (element.make?.isNotEmpty == true &&
              element.model?.isNotEmpty == true) {
            return VehicleSelectionUiModel(
              element.make ?? '',
              element.model ?? '',
            );
          } else {
            return null;
          }
        })
        .whereType<VehicleSelectionUiModel>()
        .toList();
  }

  VehicleFeedbackUiModel _mapToVehicleUiModel(VehicleFeedback response) {
    return VehicleFeedbackUiModel(
      make: response.make ?? '',
      model: response.model ?? '',
      price: response.price.toString(),
      feedback: response.feedback ?? '',
      isPositiveFeedback: response.positiveCustomerFeedback ?? false,
    );
  }
}
