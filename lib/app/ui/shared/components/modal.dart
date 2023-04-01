import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Modal extends StatelessWidget {
  final void Function()? onConfirm;
  const Modal({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Deletar item?",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Você realmente deseja deletar esse item?",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    //Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: Colors.grey,
                              minimumSize: const Size(0, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.back(result: true);
                            },
                            child: const Text(
                              'Cancelar',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              backgroundColor: Colors.red,
                              minimumSize: const Size(0, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: onConfirm,
                            child: const Text(
                              'Deletar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
