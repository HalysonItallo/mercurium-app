import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mercurium_app/app/ui/pages/auth/auth_page.dart';
import 'package:mercurium_app/app/ui/pages/control/control_page.dart';
import 'package:mercurium_app/app/ui/pages/signin/sign_in_page.dart';
import 'package:mercurium_app/app/ui/pages/signup/sign_up_page.dart';
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
      home: const AuthPage(),
      getPages: [
        GetPage(
          name: '/wallet-form',
          page: () => WalletFormPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/control',
          page: () => const ControlPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/sign-in',
          page: () => const SignInPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/auth',
          page: () => const AuthPage(),
          binding: MainBinding(),
        ),
        GetPage(
          name: '/sign-up',
          page: () => const SignUpPage(),
          binding: MainBinding(),
        )
      ],
    );
  }
}
