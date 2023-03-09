import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_controller.dart';
import 'package:mercurium_app/app/ui/pages/wallet/widgets/dropdown_list_financial_record_filter.dart';
import 'package:mercurium_app/app/ui/pages/wallet/widgets/list_financial_record.dart';
import 'package:mercurium_app/app/ui/pages/wallet/widgets/summary_wallet.dart';
import 'package:mercurium_app/app/ui/shared/utils/select_type.dart';
import 'package:mercurium_app/app/ui/shared/components/text_half_view_bold_with_future_value.dart';

class WalletPage extends GetView<WalletController> {
  WalletPage({super.key});

  final List<String> items = ["Todos", "A pagar", "A receber"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      child: Column(
        children: [
          SummaryWallet(
            futureBalance: controller.getBalance(),
            futureActualBalance: controller.getActualBalance(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    selectType<Widget>(controller.selectedType.value, items, [
                      Container(),
                      TextHalfViewBoldFutureValue(
                        regularText: "A pagar: ",
                        futureBoldText: controller
                            .getBalanceByType(controller.selectedType.value),
                        icon: const Icon(
                          Icons.credit_card_off,
                          color: Colors.red,
                        ),
                        fontSizeBoldText: 14,
                      ),
                      TextHalfViewBoldFutureValue(
                        regularText: "A receber: ",
                        futureBoldText: controller.getBalanceByType(
                          controller.selectedType.value,
                        ),
                        icon: const Icon(
                          Icons.payments,
                          color: Colors.green,
                        ),
                        fontSizeBoldText: 14,
                      )
                    ]),
                    DropdownListFinancialRecordFilter(
                      items: items,
                      height: 40,
                      selectedValue: controller.selectedType.value,
                      onChanged: (value) {
                        controller.changeSelectedType(value);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Obx(
              () => ListFinancialRecord(
                future: controller.getFinancialRecordsByType(
                  controller.selectedType.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
