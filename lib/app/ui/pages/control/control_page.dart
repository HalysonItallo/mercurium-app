import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/control/controllers/control_controller.dart';

class ControlPage extends GetView<ControlController> {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.selectedIndex.value = 0;

    return Scaffold(
      body: Obx(
        () => Center(
          child: controller.widgetOptions
              .elementAt(controller.selectedIndex.value),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Carteira',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuração',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.green,
          onTap: controller.changeSelectedIndex,
        ),
      ),
      floatingActionButton: Obx(
        () {
          if (controller.selectedIndex.value == 1) {
            return FloatingActionButton(
              onPressed: () => Get.toNamed(
                "/wallet-form",
              ),
              child: const Icon(Icons.add),
            );
          }
          return Container();
        },
      ),
    );
  }
}
