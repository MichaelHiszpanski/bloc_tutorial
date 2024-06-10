import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginResuested>((event, emit) async {
      try {
        final email = event.email;
        final password = event.password;
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

        if (!emailRegex.hasMatch(email)) {
          emit(AuthFailure('Invalid email format'));
          return;
        } else if (password.length < 6) {
          emit(AuthFailure('Password length should be at least 6 characters'));
          return;
        }

        await Future.delayed(const Duration(seconds: 2), () {
          return emit(AuthSuccess(uid: '$email-$password'));
        });
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });
  }
}
