import 'package:flutter/material.dart';
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xffDDDDDD),
            blurRadius: 6.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
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
