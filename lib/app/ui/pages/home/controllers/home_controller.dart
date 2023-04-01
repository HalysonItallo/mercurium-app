import 'package:get/get.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_actual_balance_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_balance_by_type_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_balance_usecase.dart';

class HomeController extends GetxController {
  final GetBalanceByTypeUsecase getBalanceByTypeUsecase;
  final GetActualBalanceUsecase getActualBalanceUsecase;
  final GetBalanceUsecase getBalanceUsecase;

  HomeController({
    required this.getActualBalanceUsecase,
    required this.getBalanceByTypeUsecase,
    required this.getBalanceUsecase,
  });

  Future<double> getBalanceByType(String? type) {
    return getBalanceByTypeUsecase.call(type);
  }

  Future<double> getActualBalance() async {
    return getActualBalanceUsecase.call();
  }

  Future<double> getBalance() {
    return getBalanceUsecase.call();
  }
}
