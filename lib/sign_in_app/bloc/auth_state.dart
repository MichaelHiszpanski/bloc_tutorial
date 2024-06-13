part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {
  final String uid;

  AuthSuccess({required this.uid});
  @override
  List<Object?> get props => [uid];
}

final class AuthFailure extends AuthState {
  final String error;
  final List<String> emailErrors;
  final List<String> passwordErrors;

  AuthFailure({
    required this.error,
    this.emailErrors = const [],
    this.passwordErrors = const [],
  });
  AuthFailure copyWith({
    String? error,
    List<String>? emailErrors,
    List<String>? passwordErrors,
  }) {
    return AuthFailure(
      error: error ?? this.error,
      emailErrors: emailErrors ?? this.emailErrors,
      passwordErrors: passwordErrors ?? this.passwordErrors,
    );
  }

  @override
  List<Object?> get props => [error];
}

final class AuthLoading extends AuthState {}
