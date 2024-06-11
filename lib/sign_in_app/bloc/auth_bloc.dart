import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogOutRequested>(_onAuthLogOutRequest);
  }

  void _onAuthLoginRequested(event, emit) async {
    emit(AuthLoading());
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
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthLogOutRequest(event, emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
