import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/home/controllers/home_controller.dart';
import 'package:mercurium_app/app/ui/pages/home/widgets/future_bar_graph.dart';
import 'package:mercurium_app/app/ui/pages/home/widgets/future_pie_chart.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_box_shadow.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
        child: Column(
          children: [
            CustomBoxShadow(
              margin: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      'Gráfico de porcentagem dos valores',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FuturePieChart(
                    colorList: const [
                      Colors.green,
                      Colors.red,
                    ],
                    controller: controller,
                  )
                ],
              ),
            ),
            CustomBoxShadow(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Gráfico de valores em reais',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBarGraph(
                    height: MediaQuery.of(context).size.height * 0.40,
                    padding: const EdgeInsets.all(8),
                    controller: controller,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
