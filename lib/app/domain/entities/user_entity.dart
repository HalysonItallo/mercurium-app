import 'package:mercurium_app/app/domain/entities/financial_record_entity.dart';

abstract class UserEntity {
  late int id;
  late String name;
  late String email;
  late String cellphone;
  late String password;
  late List<FinancialRecordEntity> financialRecords;
}
