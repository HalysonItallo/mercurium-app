import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class DeleteFinancialRecordUsecase {
  final FinancialRecordRepository financialRecordRepository;

  DeleteFinancialRecordUsecase({required this.financialRecordRepository});

  Future<bool> call(String id) async {
    return await financialRecordRepository.deleteFinancialRecord(id);
  }
}
