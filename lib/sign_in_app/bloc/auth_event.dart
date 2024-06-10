part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginResuested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginResuested({required this.email, required this.password});
}
