import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/signin/controllers/sign_in_controller.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_text_form_field.dart';
import 'package:mercurium_app/app/ui/shared/components/text_half_view_bold.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

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
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: const TextHalfViewBold(
                  regularText: "Mercurium",
                  fontSizeRegularText: 36,
                  icon: Icon(
                    Icons.wallet,
                    color: Colors.green,
                  ),
                ),
              ),
              Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: controller.emailController,
                      hintText: "Email",
                      validator: controller.validationIsEmpty,
                    ),
                    CustomTextFormField(
                      controller: controller.passwordController,
                      hintText: "Senha",
                      validator: controller.validationIsEmpty,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed("/sign-up");
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        disabledForegroundColor:
                            Colors.grey.withOpacity(0.38), // Disable color
                      ),
                      child: const Text("Ainda não tem cadastro?"),
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
                        child: const Text('Entrar'),
                        onPressed: () {
                          controller.login();
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
