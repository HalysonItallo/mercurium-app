import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class GetBalanceByTypeUsecase {
  final FinancialRecordRepository financialRecordRepository;

  GetBalanceByTypeUsecase({required this.financialRecordRepository});

  Future<double> call(String? type) async {
    return await financialRecordRepository.getBalanceByType(type);
  }
}
