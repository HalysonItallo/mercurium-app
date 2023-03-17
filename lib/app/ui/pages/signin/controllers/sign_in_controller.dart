import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/domain/usecases/user/login_usecase.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final LoginUsecase loginUsecase;

  SignInController({required this.loginUsecase});

  Future login() async {
    if (formKey.currentState?.validate() ?? false) {
      var result = await loginUsecase.call(
        emailController.text,
        passwordController.text,
      );

      if (result) {
        emailController.text = "";
        passwordController.text = "";
        Get.offAllNamed("/control");
      } else {
        Get.defaultDialog(
          title: "Verifique email ou senha",
          middleText: "Não foi possível entrar na conta",
          titlePadding: const EdgeInsets.all(18),
          cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFFFFFFF),
              backgroundColor: Colors.red,
              minimumSize: const Size(0, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => {Get.back(result: true)},
            child: const Text(
              'Ok',
            ),
          ),
        );
      }
    }
  }

  String? validationIsEmpty(String? val) {
    if (val?.isEmpty ?? false) {
      return "Preencha todos os campos";
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
