import 'package:flutter/material.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_box_shadow.dart';
import 'package:mercurium_app/app/ui/shared/components/text_half_view_bold_with_future_value.dart';

class SummaryWallet extends StatelessWidget {
  final Future<double> futureActualBalance;
  final Future<double> futureBalance;

  const SummaryWallet({
    super.key,
    required this.futureActualBalance,
    required this.futureBalance,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBoxShadow(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextHalfViewBoldFutureValue(
            regularText: "Saldo atual: ",
            futureBoldText: futureActualBalance,
          ),
          TextHalfViewBoldFutureValue(
            regularText: "Saldo final: ",
            futureBoldText: futureBalance,
          ),
        ],
      ),
    );
  }
}
