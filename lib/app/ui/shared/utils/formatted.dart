import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class FormattedDate {
  static String toViewDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(date);

    return formatted;
  }

  static DateTime toDateTime(String date) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);
    return dateTime;
  }
}

class FormattedValue {
  final CurrencyTextInputFormatter formatter;

  FormattedValue({required this.formatter});

  double toDoubleValue() {
    return formatter.getUnformattedValue().toDouble();
  }

  String toViewValue(String value) {
    if (value.split(".")[1].length == 1) {
      value += "0";
    }

    return formatter.format(value);
  }
}
