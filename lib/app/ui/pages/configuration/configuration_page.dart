import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/configuration/controllers/configuration_controller.dart';

class ConfigurationPage extends GetView<ConfigurationController> {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sair"),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () async {
                await controller.signOut();
              },
            )
          ],
        )
      ],
    );
  }
}
