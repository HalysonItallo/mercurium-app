import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_shimmer.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class TextHalfViewBoldFutureValue extends StatelessWidget {
  final String regularText;
  final Future<double> futureBoldText;
  final double? fontSizeRegularText;
  final double? fontSizeBoldText;

  final Icon? icon;

  TextHalfViewBoldFutureValue({
    super.key,
    required this.regularText,
    required this.futureBoldText,
    this.fontSizeRegularText = 16,
    this.fontSizeBoldText = 16,
    this.icon,
  });

  final FormattedValue formatted = Get.find<FormattedValue>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          regularText,
          style: TextStyle(
            fontSize: fontSizeRegularText,
            fontWeight: FontWeight.bold,
          ),
        ),
        FutureBuilder(
          future: futureBoldText,
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: 14,
                  child: const Text(
                    'Sem conexão',
                    style: TextStyle(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                return CustomShimmer(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 14,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: Colors.white,
                    ),
                  ),
                );

              case ConnectionState.done:
                double? data = snapshot.data;

                if (snapshot.hasData) {
                  return Text(
                    formatted.toViewValue("$data"),
                    style: TextStyle(
                      fontSize: fontSizeBoldText,
                    ),
                    textAlign: TextAlign.start,
                  );
                } else if (snapshot.hasError) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 14,
                    child: Text(
                      "${snapshot.error}".substring(11),
                      style: const TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 14,
                    child: const Text(
                      'Sem conexão',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        icon ?? Container(),
      ],
    );
  }
}
