import 'package:car_on_sale_challenge/data_access_layer/services/vin_service.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/register_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_page.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/bloc/vehicle_validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/vin_page.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/bloc/vehicle_state_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_age/vehicle_state_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleConfigurator {
  final BuildContext context;
  ModuleConfigurator(this.context);

  Widget configureRegistrationPage() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(),
        ),
        BlocProvider<ValidatorBloc>(
          create: (BuildContext context) => ValidatorBloc(),
        ),
      ],
      child: RegisterPage(),
    );
  }

  Widget configureVINPage() {
    return BlocProvider<VehicleValidatorBloc>(
      create: (BuildContext context) => VehicleValidatorBloc(),
      child: VehicleIdentificationPage(),
    );
  }

  Widget configureVehicleStatePage(String vin) {
    return BlocProvider<VehicleStateBloc>(
      create:
          (BuildContext context) =>
              VehicleStateBloc(vinService: VINService(vin)),
      child: VehicleStatePage(),
    );
  }
}
