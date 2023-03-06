import 'package:mercurium_app/app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<bool> getUserByEmailAndPassword(String email, String password);
  Future<bool> createUser(UserEntity user);
}
