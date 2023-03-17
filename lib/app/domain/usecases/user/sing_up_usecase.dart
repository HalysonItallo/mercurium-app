import 'package:mercurium_app/app/domain/repositories/user_repository.dart';

class SignUpUsecase {
  final UserRepository userRepository;

  SignUpUsecase({required this.userRepository});

  Future<bool> call(String email, String password) async {
    return await userRepository.signUp(email, password);
  }
}
