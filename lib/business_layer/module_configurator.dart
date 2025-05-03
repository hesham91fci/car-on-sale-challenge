import 'package:car_on_sale_challenge/business_layer/domain_models/user.dart';
import 'package:car_on_sale_challenge/data_access_layer/local_storage/local_starage_manager.dart';
import 'package:car_on_sale_challenge/data_access_layer/local_storage/record_name.dart';
import 'package:car_on_sale_challenge/data_access_layer/services/vin_service.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/register_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/blocs/validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/register/register_page.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/bloc/vehicle_validator_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_identification/vin_page.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/bloc/vehicle_state_bloc.dart';
import 'package:car_on_sale_challenge/presentation_layer/vehicle_state_page/vehicle_state_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleConfigurator {
  final BuildContext context;
  ModuleConfigurator(this.context);

  Future<Widget> configureHomePage() async {
    final currentUser = await LocalStorageManager.shared.get(
      RecordName.currentUser,
    );
    if (currentUser == null) {
      return configureRegistrationPage();
    }
    return configureVINPage();
  }

  Future<Widget?> configureDrawer() async {
    final userJson = await LocalStorageManager.shared.get(
      RecordName.currentUser,
    );
    if (userJson == null) {
      return null;
    }
    final currentUser = User.fromJson(userJson);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Welcome ${currentUser.firstName ?? ''}'),
          ),
          ListTile(
            title: Text('logout'),
            onTap: () async {
              if (context.mounted) {
                await LocalStorageManager.shared.delete(RecordName.currentUser);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => configureRegistrationPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

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

  showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
