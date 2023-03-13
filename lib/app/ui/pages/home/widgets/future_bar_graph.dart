import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:mercurium_app/app/ui/pages/home/controllers/home_controller.dart';

class FutureBarGraph extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? padding;
  final HomeController controller;

  const FutureBarGraph({
    super.key,
    this.height,
    this.padding,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait<double>(
        [
          controller.getActualBalance(),
          controller.getBalanceByType("A receber"),
          controller.getBalanceByType("A pagar"),
        ],
      ),
      builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
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
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            List<double>? data = snapshot.data;

            if (snapshot.hasData) {
              return Container(
                padding: padding,
                height: height,
                child: Chart(
                  data: [
                    {'category': "Saldo Atual", "balance": data?[0]},
                    {'category': "A receber", "balance": data?[1]},
                    {'category': "A pagar", "balance": data?[2]},
                  ],
                  variables: {
                    'category': Variable(
                      accessor: (Map map) => map['category'] as String,
                    ),
                    'balances': Variable(
                      accessor: (Map map) => map['balance'] as num,
                    ),
                  },
                  elements: [IntervalElement()],
                  axes: [
                    Defaults.horizontalAxis,
                    Defaults.verticalAxis,
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${snapshot.error}".substring(11),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      " \nNão foi possível encontrar os dados",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
    );
  }
}
