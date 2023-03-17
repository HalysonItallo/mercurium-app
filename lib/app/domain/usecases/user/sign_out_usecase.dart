import 'package:mercurium_app/app/domain/repositories/user_repository.dart';

class SignOutUsecase {
  final UserRepository userRepository;

  SignOutUsecase({required this.userRepository});

  Future<bool> call() async {
    return await userRepository.signOut();
  }
}
