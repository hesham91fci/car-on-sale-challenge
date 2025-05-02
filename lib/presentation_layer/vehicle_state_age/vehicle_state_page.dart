import 'package:car_on_sale_challenge/base/base_state.dart';
import 'package:car_on_sale_challenge/base/base_stateful_widget.dart'
    as base_stateful;
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/bloc/vehicle_state_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/event/vehicle_state_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleStatePage extends base_stateful.BaseStatefulWidget {
  const VehicleStatePage({super.key});

  @override
  base_stateful.BaseState<VehicleStatePage> createState() =>
      _VehicleStatePageState();
}

class _VehicleStatePageState extends base_stateful.BaseState<VehicleStatePage> {
  VehicleStateBloc? _vehicleStateBloc;
  @override
  void initState() {
    super.initState();
    _vehicleStateBloc = BlocProvider.of<VehicleStateBloc>(context);
    _vehicleStateBloc?.add(VehicleStateEvent());
  }

  @override
  Widget getBody(BuildContext context) {
    return BlocBuilder<VehicleStateBloc, BaseState>(
      builder: (context, state) {
        return Center(child: state.getBody(context));
      },
    );
  }
}
