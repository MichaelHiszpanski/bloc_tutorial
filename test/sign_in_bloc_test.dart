import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_tutorial/sign_in_app/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sign-In Bloc', () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc();
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state is AuthState', () {
      expect(authBloc.state, AuthInitial());
    });
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when AuthLoginRequested is added and login is successful',
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(AuthLoginRequested(email: "wp@wp.pl", password: "123456")),
      wait: const Duration(seconds: 3),
      expect: () => [AuthLoading(), AuthSuccess(uid: "wp@wp.pl-123456")],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when AuthLoginRequested is added and an exception occurs',
      build: () => authBloc,
      act: (bloc) {
        bloc.add(
            AuthLoginRequested(email: "invalid-email", password: "123456"));
      },
      wait: const Duration(seconds: 3),
      expect: () => [AuthLoading(), AuthFailure(error: 'Invalid email format')],
    );
  });
}
