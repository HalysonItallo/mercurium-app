import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/signup/controllers/sign_up_controller.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_text_form_field.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: controller.emailController,
                      hintText: "Email",
                      validator: controller.validationEmail,
                    ),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      hintText: "Senha",
                      validator: controller.validationPassword,
                    ),
                    CustomTextFormField(
                      controller: controller.confirmPasswordController,
                      hintText: "Confirme sua senha",
                      validator: controller.validationConfirmPassword,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed("/sign-in");
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        disabledForegroundColor:
                            Colors.grey.withOpacity(0.38), // Disable color
                      ),
                      child: const Text("Já possui cadastro?"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        child: const Text('Cadastrar'),
                        onPressed: () async {
                          await controller.signUp();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
