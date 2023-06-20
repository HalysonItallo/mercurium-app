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
                  axes: [
                    Defaults.horizontalAxis,
                    Defaults.verticalAxis,
                  ],
                  marks: [
                    IntervalMark(
                      label: LabelEncode(
                          encoder: (tuple) =>
                              Label(tuple['category'].toString())),
                      elevation: ElevationEncode(value: 0, updaters: {
                        'tap': {true: (_) => 5}
                      }),
                      color:
                          ColorEncode(value: Defaults.primaryColor, updaters: {
                        'tap': {false: (color) => color.withAlpha(100)}
                      }),
                    )
                  ],
                  selections: {'tap': PointSelection(dim: Dim.x)},
                  tooltip: TooltipGuide(),
                  crosshair: CrosshairGuide(),
                ),
                // Chart(
                //   data: [
                //     {'category': "Saldo Atual", "balance": data?[0]},
                //     {'category': "A receber", "balance": data?[1]},
                //     {'category': "A pagar", "balance": data?[2]},
                //   ],
                //   variables: {
                //     'time': Variable(
                //       accessor: (TimeSeriesSales datum) => datum.time,
                //       scale: TimeScale(
                //         formatter: (time) => _monthDayFormat.format(time),
                //       ),
                //     ),
                //   },
                //   marks: [
                //     LineMark(
                //       shape: ShapeEncode(value: BasicLineShape(dash: [5, 2])),
                //       selected: {
                //         'touchMove': {1}
                //       },
                //     )
                //   ],
                //   coord: RectCoord(color: const Color(0xffdddddd)),
                //   axes: [
                //     Defaults.horizontalAxis,
                //     Defaults.verticalAxis,
                //   ],
                //   selections: {
                //     'touchMove': PointSelection(
                //       on: {
                //         GestureType.scaleUpdate,
                //         GestureType.tapDown,
                //         GestureType.longPressMoveUpdate
                //       },
                //       dim: Dim.x,
                //     )
                //   },
                //   tooltip: TooltipGuide(
                //     followPointer: [false, true],
                //     align: Alignment.topLeft,
                //     offset: const Offset(-20, -20),
                //   ),
                //   crosshair: CrosshairGuide(followPointer: [false, true]),
                // ),
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
