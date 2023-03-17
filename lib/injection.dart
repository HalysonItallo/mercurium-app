import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:mercurium_app/app/data/repositories/firestore/financial_record_firestore_imp.dart';
import 'package:mercurium_app/app/data/repositories/firestore/user_firestore_imp.dart';
import 'package:mercurium_app/app/domain/repositories/financial_record_repository.dart';
import 'package:mercurium_app/app/domain/repositories/user_repository.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/create_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/delete_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_actual_balance_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_all_financial_records_usecase.dart';

import 'package:get/instance_manager.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_balance_by_type_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_balance_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/get_financial_records_by_type_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/financial_record/update_financial_record_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/user/check_user_is_login_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/user/login_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/user/sign_out_usecase.dart';
import 'package:mercurium_app/app/domain/usecases/user/sing_up_usecase.dart';
import 'package:mercurium_app/app/ui/pages/auth/controllers/auth_controller.dart';
import 'package:mercurium_app/app/ui/pages/configuration/controllers/configuration_controller.dart';

import 'package:mercurium_app/app/ui/pages/control/controllers/control_controller.dart';
import 'package:mercurium_app/app/ui/pages/home/controllers/home_controller.dart';
import 'package:mercurium_app/app/ui/pages/signin/controllers/sign_in_controller.dart';
import 'package:mercurium_app/app/ui/pages/signup/controllers/sign_up_controller.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_controller.dart';
import 'package:mercurium_app/app/ui/pages/wallet/controllers/wallet_form_controller.dart';
import 'package:mercurium_app/app/ui/shared/utils/formatted.dart';

class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    //Instance repository
    Get.lazyPut<FinancialRecordRepository>(
        () => FinancialRecordeFirestoreImp());
    Get.lazyPut<UserRepository>(() => UserFirestoreImp());

    //Instance controllers
    Get.lazyPut<ControlController>(
      () => ControlController(),
    );

    Get.lazyPut<AuthController>(
      () => AuthController(
        checkUserIsLoginUsecase: CheckUserIsLoginUsecase(
          userRepository: Get.find<UserRepository>(),
        ),
      ),
    );

    Get.lazyPut<WalletController>(
      () => WalletController(
        getAllFinancialRecordsUsecase: GetAllFinancialRecordsUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        getFinancialRecordsByTypeUsecase: GetFinancialRecordsByTypeUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        getBalanceByTypeUsecase: GetBalanceByTypeUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        getBalanceUsecase: GetBalanceUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        deleteFinancialRecordUsecase: DeleteFinancialRecordUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        getActualBalanceUsecase: GetActualBalanceUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
      ),
    );

    Get.lazyPut<WalletFormController>(
      () => WalletFormController(
        createFinancialRecordUsecase: CreateFinancialRecordUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        updateFinancialRecordUsecase: UpdateFinancialRecordUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        getActualBalanceUsecase: GetActualBalanceUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        getBalanceByTypeUsecase: GetBalanceByTypeUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
        getBalanceUsecase: GetBalanceUsecase(
          financialRecordRepository: Get.find<FinancialRecordRepository>(),
        ),
      ),
    );

    Get.lazyPut<SignInController>(
      () => SignInController(
        loginUsecase: LoginUsecase(
          userRepository: Get.find<UserRepository>(),
        ),
      ),
    );

    Get.lazyPut<SignUpController>(
      () => SignUpController(
        signUpUsecase: SignUpUsecase(
          userRepository: Get.find<UserRepository>(),
        ),
      ),
    );

    Get.lazyPut<ConfigurationController>(
      () => ConfigurationController(
        signOutUsecase: SignOutUsecase(
          userRepository: Get.find<UserRepository>(),
        ),
      ),
    );
    //Intance utils
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
