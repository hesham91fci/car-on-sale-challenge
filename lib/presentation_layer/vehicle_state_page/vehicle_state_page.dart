import 'package:car_on_sale_challenge/base/bloc/bloc_base_api_state.dart';
import 'package:car_on_sale_challenge/base/base_stateful_widget.dart';
import 'package:car_on_sale_challenge/presentation_layer/common/error_state.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/bloc/vehicle_state_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/event/vehicle_state_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleStatePage extends BaseStatefulWidget {
  const VehicleStatePage({super.key});

  @override
  BaseState<VehicleStatePage> createState() => _VehicleStatePageState();
}

class _VehicleStatePageState extends BaseState<VehicleStatePage> {
  VehicleStateBloc? _vehicleStateBloc;
  @override
  void initState() {
    super.initState();
    _vehicleStateBloc = BlocProvider.of<VehicleStateBloc>(context);
    _vehicleStateBloc?.add(VehicleStateEvent());
  }

  @override
  Widget getBody(BuildContext context) {
    return BlocConsumer<VehicleStateBloc, BlocBaseApiState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnack(
            '${state.errorModel.message ?? ''}:: Will try to Retrieve offline',
            handler: () => _vehicleStateBloc?.add(VehicleStateEvent()),
            actionTitle: 'retry',
          );
        }
      },
      builder: (context, state) {
        return Center(child: state.getBody(context));
      },
    );
  }
}
