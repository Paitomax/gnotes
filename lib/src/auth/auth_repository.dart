import 'package:firebase_auth/firebase_auth.dart';
import 'package:gnotes/src/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../store_provider.dart';
import 'auth_repository_interface.dart';

class AuthRepository extends AuthRepositoryInterface {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<bool> isLoggedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  @override
  Future<FirebaseUser> loginWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    final user = await _firebaseAuth.currentUser();
    await _saveUser(user);

    return user;
  }

  @override
  Future<void> logout() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  @override
  Future<FirebaseUser> getUser() {
    return _firebaseAuth.currentUser();
  }

  Future<void> _saveUser(FirebaseUser firebaseUser) async {
    User user = User(firebaseUser.displayName, firebaseUser.email,
        id: firebaseUser.uid);
    await StoreProvider.addUser(user);
  }
}
