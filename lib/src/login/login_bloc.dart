import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../sign_in.dart';
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
      await signInWithGoogle();
      yield LoginLoggedInState();
    } catch (error) {
      yield LoginErrorState(error);
    }
  }
}
