import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/domain/usecases/user/sing_up_usecase.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final SignUpUsecase signUpUsecase;

  SignUpController({required this.signUpUsecase});

  String? validationEmail(String? val) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);

    if (val?.isNotEmpty ?? false) {
      if (!regExp.hasMatch(val!)) {
        return 'Por favor insira um email válido';
      }
    } else {
      return "Preencha todos os campos";
    }
    return null;
  }

  String? validationPassword(String? val) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    if (val?.isNotEmpty ?? false) {
      if (!regExp.hasMatch(val!)) {
        return 'Insira uma senha contendo pelo menos:\n1 caracter maiúsculo\n1 caracter minúsculo\n1 símbolo (!@#\$&*~)\n8 caracteres';
      }
    } else {
      return "Preencha todos os campos";
    }
    return null;
  }

  String? validationConfirmPassword(String? val) {
    if (val?.isNotEmpty ?? false) {
      if (val != passwordController.text) {
        return 'As senhas não são iguais';
      }
    } else {
      return "Preencha todos os campos";
    }
    return null;
  }

  Future signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        var result = await signUpUsecase.call(
          emailController.text,
          passwordController.text,
        );

        if (result) {
          emailController.text = "";
          passwordController.text = "";
          confirmPasswordController.text = "";

          Get.defaultDialog(
            title: "",
            middleText: "Usuário criado com sucesso",
            titlePadding: const EdgeInsets.all(18),
            cancel: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFFFFFFF),
                backgroundColor: Colors.green,
                minimumSize: const Size(0, 35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => {
                Get.back(result: true),
                Get.offAllNamed("/sign-in"),
              },
              child: const Text(
                'Ok',
              ),
            ),
          );
        } else {
          Get.defaultDialog(
            title: "",
            middleText: "Não foi possível criar a conta",
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
              onPressed: () => {
                Get.back(result: true),
              },
              child: const Text(
                'Ok',
              ),
            ),
          );
        }
      } catch (e) {
        Get.defaultDialog(
          title: "Não foi possível criar a conta",
          middleText: "$e".substring(11),
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
            onPressed: () => {
              Get.back(result: true),
            },
            child: const Text(
              'Ok',
            ),
          ),
        );
      }
    }
  }
}
