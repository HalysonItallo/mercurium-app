import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';

class GetBalanceUsecase {
  final FinancialRecordRepository financialRecordRepository;

  GetBalanceUsecase({required this.financialRecordRepository});

  Future<double> call() async {
    return await financialRecordRepository.getBalance();
  }
}
