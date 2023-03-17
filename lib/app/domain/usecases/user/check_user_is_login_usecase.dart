import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercurium_app/app/domain/repositories/user_repository.dart';

class CheckUserIsLoginUsecase {
  final UserRepository userRepository;

  CheckUserIsLoginUsecase({required this.userRepository});

  Stream<User?> call() {
    return userRepository.checkUserIsLogin();
  }
}
