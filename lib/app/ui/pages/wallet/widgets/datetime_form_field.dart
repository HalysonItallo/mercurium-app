import 'package:flutter/material.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class DatetimeFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;

  const DatetimeFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          hintText: 'Data de recebimento ou pagamento',
          hintStyle: TextStyle(fontSize: 16),
          suffixIcon: Icon(Icons.date_range),
        ),
        onTap: () async {
          DateTime date;
          FocusScope.of(context).requestFocus(FocusNode());

          date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ) ??
              DateTime(1900);

          controller.text = FormattedDate.toViewDate(date);
        },
      ),
    );
  }
}
