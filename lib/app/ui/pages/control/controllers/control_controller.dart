import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/configuration/configuration_page.dart';
import 'package:mercurium_app/app/ui/pages/home/home_page.dart';
import 'package:mercurium_app/app/ui/pages/wallet/wallet_page.dart';

class ControlController extends GetxController {
  final dynamic argumentData = Get.arguments;

  final List<Widget> widgetOptions = <Widget>[
    HomePage(),
    WalletPage(),
    const ConfigurationPage(),
  ];

  var selectedIndex = 0.obs;

  @override
  void onInit() {
    selectedIndex.value = argumentData?[0]?["index"] ?? 0;
    super.onInit();
  }

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
