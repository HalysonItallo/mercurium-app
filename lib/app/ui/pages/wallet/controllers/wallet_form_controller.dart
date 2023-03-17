import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/create_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/update_financial_record_usecase.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class WalletFormController extends GetxController {
  final CreateFinancialRecordUsecase createFinancialRecordUsecase;
  final UpdateFinancialRecordUsecase updateFinancialRecordUsecase;

  WalletFormController({
    required this.createFinancialRecordUsecase,
    required this.updateFinancialRecordUsecase,
  });

  FormattedValue formatted = Get.find<FormattedValue>();

  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final receivedAtController = TextEditingController();
  String? initialValue;

  dynamic argumentData = Get.arguments;

  @override
  void onInit() {
    descriptionController.text = argumentData?[0]?['data']?.description ?? "";
    categoryController.text = argumentData?[0]?['data']?.category ?? "";
    receivedAtController.text = argumentData?[0]?['data']?.receivedAt != null
        ? FormattedDate.toViewDate(argumentData?[0]?['data']?.receivedAt)
        : "";

    initialValue = argumentData?[0]?['data']?.value?.toString() != null
        ? formatted.toViewValue(argumentData[0]['data'].value.toString())
        : null;
    selectedType.value = argumentData?[0]?['data']?.type ?? "A pagar";
    super.onInit();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    categoryController.dispose();
    super.onClose();
  }

  var selectedType = 'A pagar'.obs;

  void changeSelectedType(String? newValue) {
    selectedType.value = newValue ?? 'Todos';
  }

  String? validationText(String? val) {
    if (val?.isNotEmpty ?? false) {
      if (verifyLengthInput(val ?? '', minLen: 30)) {
        return 'Texto com no máximo 30 caracteres';
      }
    } else {
      return "Preencha todos os campos";
    }
    return null;
  }

  String? validationNumber(String? val) {
    if (val?.isNotEmpty ?? false) {
      if (verifyLengthInput(val ?? '', minLen: 15)) {
        return 'Valor com no máximo 15 dígitos';
      }
    } else {
      return "Preencha todos os campos";
    }
    return null;
  }

  bool verifyLengthInput(String val, {int minLen = 30}) {
    if (val.length < minLen) {
      return false;
    }
    return true;
  }

  Future<bool> createFinancialRecord() async {
    if (formKey.currentState?.validate() ?? false) {
      return await createFinancialRecordUsecase.call(
        FinancialRecordModel(
          value: formatted.toDoubleValue(),
          createdAt: DateTime.now(),
          receivedAt: FormattedDate.toDateTime(receivedAtController.text),
          description: descriptionController.text,
          type: selectedType.value,
          category: categoryController.text,
        ),
      );
    }
    return false;
  }

  Future<bool> updateFinancialRecord() async {
    if (formKey.currentState?.validate() ?? false) {
      return await updateFinancialRecordUsecase.call(
        FinancialRecordModel(
          id: argumentData?[0]?['data']?.id,
          value: formatted.toDoubleValue(),
          receivedAt: FormattedDate.toDateTime(receivedAtController.text),
          description: descriptionController.text,
          type: selectedType.value,
          category: categoryController.text,
        ),
      );
    }
    return false;
  }
}
