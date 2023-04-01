import 'package:flutter/material.dart';
import 'package:mercurium_app/app/ui/pages/home/controllers/home_controller.dart';
import 'package:pie_chart/pie_chart.dart';

class FuturePieChart extends StatelessWidget {
  final List<Color> colorList;
  final HomeController controller;

  const FuturePieChart({
    super.key,
    required this.colorList,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait<double>(
        [
          controller.getBalance(),
          controller.getBalanceByType("A pagar"),
          controller.getBalanceByType("A receber"),
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
              return PieChart(
                dataMap: <String, double>{
                  "Valor restante": data?[0] ?? 0,
                  "Valor a pagar": data?[1] ?? 0,
                },
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width * 0.25,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 21,
                totalValue: data?[2] ?? 0,
                legendOptions: const LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  decimalPlaces: 2,
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
