import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class UpdateFinancialRecordUsecase {
  final FinancialRecordRepository financialRecordRepository;

  UpdateFinancialRecordUsecase({required this.financialRecordRepository});

  Future<bool> call(FinancialRecordModel financialRecordModel) async {
    return await financialRecordRepository
        .updateFinancialRecord(financialRecordModel);
  }
}
