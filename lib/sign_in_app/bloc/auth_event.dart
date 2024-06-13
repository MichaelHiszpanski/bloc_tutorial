part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});
}

final class AuthLogOutRequested extends AuthEvent {}

final class ClearEmailErrors extends AuthEvent {}

final class ClearPasswordErrors extends AuthEvent {}
