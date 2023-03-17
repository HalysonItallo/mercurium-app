import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class GetActualBalanceUsecase {
  final FinancialRecordRepository financialRecordRepository;

  GetActualBalanceUsecase({required this.financialRecordRepository});

  Future<double> call() async {
    return await financialRecordRepository.getActualBalance();
  }
}
