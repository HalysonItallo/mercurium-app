import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16),
        ),
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
