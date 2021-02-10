import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepositoryInterface {
  AuthRepositoryInterface();

  Future<bool> isLoggedIn();

  Future<User> loginWithGoogle();

  User getUser();

  Future<void> logout();
}
