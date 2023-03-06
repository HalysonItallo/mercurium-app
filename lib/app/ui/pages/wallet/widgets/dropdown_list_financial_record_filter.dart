import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownListFinancialRecordFilter extends StatelessWidget {
  final String? selectedValue;
  final double? height;
  final void Function(String?)? onChanged;
  final List<String> items;

  const DropdownListFinancialRecordFilter({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.height,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomDropdownButton2(
        hint: "",
        dropdownItems: items,
        value: selectedValue,
        onChanged: onChanged,
      ),
    );
  }
}
