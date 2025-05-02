import 'package:flutter/material.dart';

class TextFieldState {
  final FocusNode focusNode = FocusNode();
  final TextEditingController? controller;

  TextFieldState({this.controller});
}
