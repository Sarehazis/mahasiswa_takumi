import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();

  @override
  List<Object?> get props => [];
}

@immutable
class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

@immutable
class AuthEventRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthEventRegister({
    required this.username,
    required this.email,
    required this.password,
    required String confirmPassword,
    required String confirm_password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

@immutable
class AuthEventResetPassword extends AuthEvent {
  final String email;
  const AuthEventResetPassword({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

@immutable
class AuthEventResetPasswordSent extends AuthEvent {
  const AuthEventResetPasswordSent();

  @override
  List<Object?> get props => [];
}
