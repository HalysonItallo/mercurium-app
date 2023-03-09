import 'package:mercurium_app/app/data/models/financial_record_model.dart';

abstract class FinancialRecordRepository {
  Future<bool> createFinancialRecord(FinancialRecordModel financialRecordModel);
  Future<bool> deleteFinancialRecord(String id);
  Future<bool> updateFinancialRecord(FinancialRecordModel financialRecordModel);
  Future<List<FinancialRecordModel>> getFinancialRecordsByType(String? type);
  Future<List<FinancialRecordModel>> getAllFinancialRecords();
  Future<double> getBalance();
  Future<double> getBalanceByType(String? type);
  Future<double> getActualBalance();
}
