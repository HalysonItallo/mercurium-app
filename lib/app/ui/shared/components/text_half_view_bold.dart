import 'package:flutter/material.dart';

class TextHalfViewBold extends StatelessWidget {
  final String regularText;
  final String boldText;
  final double? fontSizeRegularText;
  final double? fontSizeBoldText;
  final Icon? icon;

  const TextHalfViewBold({
    super.key,
    required this.regularText,
    required this.boldText,
    this.fontSizeBoldText = 16,
    this.fontSizeRegularText = 16,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          boldText,
          style: TextStyle(
            fontSize: fontSizeBoldText,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          regularText,
          style: TextStyle(fontSize: fontSizeRegularText),
        ),
        const SizedBox(
          width: 10,
        ),
        icon ?? Container(),
      ],
    );
  }
}
