import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;
  final bool successful;
  const AuthState({required this.isLoading, required this.successful});
}

class AuthStateLoggedIn extends AuthState {
  final String userName;
  const AuthStateLoggedIn({
    required super.isLoading,
    required super.successful,
    required this.userName,
  });

  @override
  List<Object?> get props => [isLoading, successful];

  get user => null;

  get role => null;
}

class AuthStateLoggedOut extends AuthState {
  final String errorMessage;
  const AuthStateLoggedOut({
    required super.isLoading,
    required super.successful,
    this.errorMessage = "",
  });

  @override
  List<Object?> get props => [isLoading, successful, errorMessage];
}

class AuthStatePasswordResetSent extends AuthState {
  const AuthStatePasswordResetSent({
    required super.isLoading,
    required super.successful,
  });

  @override
  List<Object?> get props => [isLoading, successful];
}
