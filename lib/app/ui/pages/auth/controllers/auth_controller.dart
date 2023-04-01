import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mercurium_app/app/domain/usecases/user/check_user_is_login_usecase.dart';

class AuthController extends GetxController {
  final CheckUserIsLoginUsecase checkUserIsLoginUsecase;

  AuthController({
    required this.checkUserIsLoginUsecase,
  });

  Stream<User?> checkUserIsLogin() {
    return checkUserIsLoginUsecase.call();
  }
}
