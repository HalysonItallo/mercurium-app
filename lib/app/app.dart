import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mercurium_app/app/ui/pages/control/control_page.dart';
import 'package:mercurium_app/app/ui/pages/wallet/wallet_form_page.dart';
import 'package:mercurium_app/injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mercurium',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ControlPage(),
      getPages: [
        GetPage(
          name: '/wallet-form',
          page: () => WalletFormPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/control-page',
          page: () => const ControlPage(),
          binding: MainBinding(),
        ),
      ],
    );
  }
}
