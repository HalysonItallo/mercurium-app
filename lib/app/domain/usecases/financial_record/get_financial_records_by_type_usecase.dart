import 'package:mercurium_app/app/data/models/financial_record_model.dart';
import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class GetFinancialRecordsByTypeUsecase {
  final FinancialRecordRepository financialRecordRepository;

  GetFinancialRecordsByTypeUsecase({required this.financialRecordRepository});

  Future<List<FinancialRecordModel>> call(String? type) async {
    return await financialRecordRepository.getFinancialRecordsByType(type);
  }
}
