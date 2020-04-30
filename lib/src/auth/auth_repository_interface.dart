import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepositoryInterface {
  AuthRepositoryInterface();

  Future<bool> isLoggedIn();

  Future<FirebaseUser> loginWithGoogle();

  Future<FirebaseUser> getUser();

  Future<void> logout();
}
