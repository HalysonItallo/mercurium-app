import 'package:get/get.dart';
import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/domain/usecases/delete_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_all_financial_records_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_balance_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_financial_records_by_type_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_balance_by_type_usecase.dart';

class WalletController extends GetxController {
  final GetAllFinancialRecordsUsecase getAllFinancialRecordsUsecase;
  final GetFinancialRecordsByTypeUsecase getFinancialRecordsByTypeUsecase;
  final GetBalanceByTypeUsecase getBalanceByTypeUsecase;
  final GetBalanceUsecase getBalanceUsecase;
  final DeleteFinancialRecordUsecase deleteFinancialRecordUsecase;

  WalletController({
    required this.getAllFinancialRecordsUsecase,
    required this.getFinancialRecordsByTypeUsecase,
    required this.getBalanceByTypeUsecase,
    required this.getBalanceUsecase,
    required this.deleteFinancialRecordUsecase,
  });

  var selectedType = 'Todos'.obs;

  void changeSelectedType(String? newValue) {
    selectedType.value = newValue ?? 'Todos';
  }

  Future<List<FinancialRecordModel>> getFinancialRecordsByType(String? type) {
    if (type == 'Todos') {
      var data = getAllFinancialRecordsUsecase.call();
      return data;
    } else {
      return getFinancialRecordsByTypeUsecase.call(type);
    }
  }

  Future<double> getBalanceByType(String? type) {
    return getBalanceByTypeUsecase.call(type);
  }

  Future<double> getBalance() {
    return getBalanceUsecase.call();
  }

  Future<bool> deleteFinancialRecord(String id) async {
    return deleteFinancialRecordUsecase.call(id);
  }
}