import 'package:car_on_sale_challenge/business_layer/module_configurator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModuleConfigurator(context).configureRegistrationPage(),
    );
  }
}
