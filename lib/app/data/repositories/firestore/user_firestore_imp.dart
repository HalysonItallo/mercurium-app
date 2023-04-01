import 'package:firebase_auth/firebase_auth.dart';
import 'package:mercurium_app/app/domain/repositories/user_repository.dart';

class UserFirestoreImp implements UserRepository {
  final userRef = FirebaseAuth.instance;

  @override
  Future<bool> signUp(String email, String password) async {
    bool itHasBeenCreated = false;

    try {
      await userRef.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      itHasBeenCreated = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('A senha deve ser mais forte');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Já existe uma conta com esse email');
      }
    }
    return itHasBeenCreated;
  }

  @override
  Future<bool> signOut() async {
    bool itHasBeenUnlogged = false;

    try {
      await FirebaseAuth.instance.signOut();
      itHasBeenUnlogged = true;
    } catch (e) {
      throw Exception("Não foi possível deslogar");
    }

    return itHasBeenUnlogged;
  }

  @override
  Stream<User?> checkUserIsLogin() {
    return userRef.authStateChanges();
  }

  @override
  Future<bool> login(String email, String password) async {
    bool itHasBeenLogged = false;

    try {
      await userRef.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      itHasBeenLogged = true;
    } catch (e) {
      if (e == 'user-not-found') {
        throw Exception('Não existe um usuário com esse email');
      } else if (e == 'wrong-password') {
        throw Exception('Senha incorreta');
      }
    }
    return itHasBeenLogged;
  }
}
