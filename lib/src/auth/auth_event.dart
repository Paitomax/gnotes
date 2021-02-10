import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAlreadyLoggedIn extends AuthEvent {
  final User user;

  AuthAlreadyLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}

class AuthForcedLoggedOut extends AuthEvent {}
