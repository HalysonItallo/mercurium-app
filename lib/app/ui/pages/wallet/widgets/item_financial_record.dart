import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_controller.dart';
import 'package:mercurium_app/app/ui/shared/components/custom_dialog.dart';
import 'package:mercurium_app/app/ui/shared/components/text_half_view_bold.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class ItemFinancialRecord extends StatelessWidget {
  final List<FinancialRecordModel>? data;
  final int index;

  ItemFinancialRecord({
    super.key,
    required this.data,
    required this.index,
  });

  final WalletController walletController = Get.find<WalletController>();
  final FormattedValue formatted = Get.find<FormattedValue>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextHalfViewBold(
                  regularText: data![index].description,
                  boldText: "Descrição: ",
                  fontSizeBoldText: 14,
                  fontSizeRegularText: 13,
                ),
                const SizedBox(height: 2),
                TextHalfViewBold(
                  regularText: formatted.toViewValue("${data![index].value}"),
                  boldText: "Valor: ",
                  fontSizeBoldText: 14,
                  fontSizeRegularText: 13,
                ),
                const SizedBox(height: 2),
                TextHalfViewBold(
                  regularText: data![index].category,
                  boldText: "Categoria: ",
                  fontSizeBoldText: 13,
                  fontSizeRegularText: 13,
                ),
                const SizedBox(height: 2),
                TextHalfViewBold(
                  regularText:
                      FormattedDate.toViewDate(data![index].createdAt!),
                  boldText: "Data: ",
                  fontSizeBoldText: 13,
                  fontSizeRegularText: 13,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed("/wallet-form", arguments: [
                      {"data": data![index]},
                    ]);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      CustomDialog(
                        onConfirm: () async {
                          var itHasBeenDeleted =
                              await walletController.deleteFinancialRecord(
                            data![index].id!,
                          );
                          Get.back(result: true);
                          if (itHasBeenDeleted) {
                            Get.defaultDialog(
                              title: "",
                              middleText: "Item deletado com sucesso",
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
                                  Get.offAllNamed("/control-page", arguments: [
                                    {"index", 1}
                                  ]),
                                },
                                child: const Text(
                                  'Ok',
                                ),
                              ),
                            );
                          } else {
                            Get.defaultDialog(
                              title: "",
                              middleText: "Não foi possível deletar o item",
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
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
