import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gnotes/src/models/user.dart';
import 'package:gnotes/src/store_provider.dart';
import '../auth_manager.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield* _mapToLoginButtonPressedEvent();
    }
  }

  Stream<LoginState> _mapToLoginButtonPressedEvent() async* {
    try {
      yield LoginLoadingState();
      FirebaseUser firebaseUser = await AuthManager.signInWithGoogle();
      User user = User(firebaseUser.displayName, firebaseUser.email, id: firebaseUser.uid);
      await StoreProvider.addUser(user);
      yield LoginLoggedInState();
    } catch (error) {
      yield LoginErrorState(error);
    }
  }
}
