import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:gnotes/src/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../store_provider.dart';
import 'auth_repository_interface.dart';

class AuthRepository extends AuthRepositoryInterface {
  final GoogleSignIn _googleSignIn;
  final fb.FirebaseAuth _firebaseAuth;

  AuthRepository({fb.FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<bool> isLoggedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<fb.User> loginWithGoogle() async {

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn().catchError((error){
      print(error);
    });
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    final user = _firebaseAuth.currentUser;
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
  fb.User getUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> _saveUser(fb.User firebaseUser) async {
    User user = User(firebaseUser.displayName, firebaseUser.email,
        id: firebaseUser.uid);
    await StoreProvider.addUser(user);
  }
}
