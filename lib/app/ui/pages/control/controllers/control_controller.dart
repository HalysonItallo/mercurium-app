import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/configuration/configuration_page.dart';
import 'package:mercurium_app/app/ui/pages/home/home_page.dart';
import 'package:mercurium_app/app/ui/pages/wallet/wallet_page.dart';

class ControlController extends GetxController {
  final List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    WalletPage(),
    const ConfigurationPage(),
  ];

  var selectedIndex = 0.obs;

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
