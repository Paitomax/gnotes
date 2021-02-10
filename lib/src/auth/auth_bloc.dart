import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gnotes/src/auth/auth_repository_interface.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryInterface authRepository;
  final FirebaseAuth firebaseAuth;

  StreamSubscription firebaseStreamSubscription;

  AuthBloc(this.authRepository, this.firebaseAuth) {
    firebaseStreamSubscription =
        firebaseAuth.authStateChanges().listen((User user) async {
      if (user != null && (!user.isAnonymous)) {
        if (state is AuthInitial) await Future.delayed(Duration(seconds: 2));
        add(AuthAlreadyLoggedIn(user));
      } else {
        add(AuthForcedLoggedOut());
      }
    });
  }

  @override
  Future<Function> close() {
    firebaseStreamSubscription?.cancel();
    return super.close();
  }

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthLoggedIn) {
      yield* _mapAuthLoggedInToState();
    } else if (event is AuthLoggedOut) {
      yield* _mapAuthLoggedOutToState();
    } else if (event is AuthForcedLoggedOut) {
      yield* _mapAuthForcedLoggedOutToState();
    } else if (event is AuthAlreadyLoggedIn) {
      yield* _mapAuthAlreadyLoggedInToState(event);
    }
  }

  Stream<AuthState> _mapAuthLoggedInToState() async* {
    try {
      final firebaseUser = await authRepository.loginWithGoogle();
      if (firebaseUser == null || firebaseUser.isAnonymous) {
        yield Unauthenticated();
      } else {
        yield Authenticated();
      }
    } catch (error) {
      await authRepository.logout();
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapAuthAlreadyLoggedInToState(
      AuthAlreadyLoggedIn event) async* {
    yield Authenticated();
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    authRepository.logout();
    yield Unauthenticated();
  }

  Stream<AuthState> _mapAuthForcedLoggedOutToState() async* {
    yield Unauthenticated();
  }
}
