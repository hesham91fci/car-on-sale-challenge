import 'package:flutter/material.dart';

class CosTextfield extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final TextEditingController? editingController;
  final String? error;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;

  const CosTextfield({
    super.key,
    required this.label,
    required this.onChanged,
    this.focusNode,
    this.editingController,
    this.error,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
      controller: editingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: error,
        errorMaxLines: 2,
      ),
    );
  }
}
