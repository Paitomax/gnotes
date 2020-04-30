import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnotes/src/auth/auth_repository.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository);

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
      await authRepository.loginWithGoogle();
      yield LoginLoggedInState();
    } catch (error) {
      yield LoginErrorState(error);
    }
  }
}
