import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:mercurium_app/app/data/repositories/firestore/financial_record_firestore_imp.dart';
import 'package:mercurium_app/app/domain/usecases/create_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/delete_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_all_financial_records_usecase.dart';
import 'package:get/instance_manager.dart';
import 'package:mercurium_app/app/domain/usecases/get_balance_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_financial_records_by_type_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/get_balance_by_type_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/update_financial_record_usecase.dart';
import 'package:mercurium_app/app/ui/pages/control/controllers/control_controller.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_controller.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_form_controller.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<ControlController>(
      ControlController(),
    );

    Get.lazyPut<WalletController>(
      () => WalletController(
        getAllFinancialRecordsUsecase: GetAllFinancialRecordsUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
        getFinancialRecordsByTypeUsecase: GetFinancialRecordsByTypeUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
        getBalanceByTypeUsecase: GetBalanceByTypeUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
        getBalanceUsecase: GetBalanceUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
        deleteFinancialRecordUsecase: DeleteFinancialRecordUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
      ),
    );

    Get.lazyPut<WalletFormController>(
      () => WalletFormController(
        createFinancialRecordUsecase: CreateFinancialRecordUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
        updateFinancialRecordUsecase: UpdateFinancialRecordUsecase(
          financialRecordRepository: FinancialRecordeFirebaseImp(),
        ),
      ),
    );

    Get.lazyPut<FormattedValue>(
      () => FormattedValue(
        formatter: CurrencyTextInputFormatter(
          locale: "pt",
          symbol: "R\$ ",
          decimalDigits: 2,
        ),
      ),
    );
  }
}
