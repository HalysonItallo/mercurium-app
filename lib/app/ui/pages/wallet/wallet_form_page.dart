import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_form_controller.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_text_form_field.dart';
import 'package:mercurium_app/app/ui/pages/wallet/widgets/datetime_form_field.dart';
import 'package:mercurium_app/app/ui/pages/wallet/widgets/dropdown_list_financial_record_filter.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class WalletFormPage extends GetView<WalletFormController> {
  WalletFormPage({super.key});

  final FormattedValue formatted = Get.find<FormattedValue>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: controller.descriptionController,
                      hintText: "Descrição",
                      validator: controller.validationText,
                    ),
                    CustomTextFormField(
                      controller: controller.categoryController,
                      hintText: "Categoria",
                      validator: controller.validationText,
                    ),
                    DatetimeFormField(
                      controller: controller.receivedAtController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            initialValue: controller.initialValue,
                            hintText: "Valor",
                            validator: controller.validationNumber,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              formatted.formatter,
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        Obx(
                          () => DropdownListFinancialRecordFilter(
                            items: const ["A pagar", "A receber"],
                            height: 60,
                            selectedValue: controller.selectedType.value,
                            onChanged: (value) {
                              controller.changeSelectedType(value);
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        child: Text(controller.argumentData == null
                            ? 'Cadastrar'
                            : 'Editar'),
                        onPressed: () async {
                          bool result;
                          if (controller.argumentData == null) {
                            result = await controller.createFinancialRecord();
                          } else {
                            result = await controller.updateFinancialRecord();
                          }

                          if (result) {
                            Get.defaultDialog(
                              title: "",
                              middleText: controller.argumentData == null
                                  ? "Item criado com sucesso"
                                  : "Item editado com sucesso",
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
                                  Get.offAllNamed("/control"),
                                },
                                child: const Text(
                                  'Ok',
                                ),
                              ),
                            );
                          } else {
                            Get.defaultDialog(
                              title: "",
                              middleText: controller.argumentData == null
                                  ? "Não foi possível criar o item"
                                  : "Não foi possível editar o item",
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
