import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<bool> signUp(String email, String password);
  Future<bool> signOut();
  Stream<User?> checkUserIsLogin();
  Future<bool> login(String email, String password);
}
