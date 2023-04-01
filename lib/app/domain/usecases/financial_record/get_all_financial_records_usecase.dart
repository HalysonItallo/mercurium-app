import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class GetAllFinancialRecordsUsecase {
  final FinancialRecordRepository financialRecordRepository;

  GetAllFinancialRecordsUsecase({required this.financialRecordRepository});

  Future<List<FinancialRecordModel>> call() async {
    return await financialRecordRepository.getAllFinancialRecords();
  }
}
