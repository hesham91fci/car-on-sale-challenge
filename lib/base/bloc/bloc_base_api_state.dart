import 'package:flutter/material.dart';

abstract class BlocBaseApiState {
  Widget getBody(BuildContext context);
  String getTitle() => '';
}
