import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/auth/controllers/auth_controller.dart';
import 'package:mercurium_app/app/ui/pages/control/control_page.dart';
import 'package:mercurium_app/app/ui/pages/signin/sign_in_page.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: controller.checkUserIsLogin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ControlPage();
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
