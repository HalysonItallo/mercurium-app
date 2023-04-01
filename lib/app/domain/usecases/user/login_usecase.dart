import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercurium_app/app/domain/repositories/user_repository.dart';

class LoginUsecase {
  final UserRepository userRepository;

  LoginUsecase({required this.userRepository});

  Future<bool> call(String email, String password) {
    return userRepository.login(email, password);
  }
}
