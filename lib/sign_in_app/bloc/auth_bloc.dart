import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogOutRequested>(_onAuthLogOutRequest);
    on<ClearEmailErrors>(_onClearEmailErrors);
    on<ClearPasswordErrors>(_onClearPasswordErrors);
  }
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    // print('AuthBlock Change- $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    //  print('AuthBlock Transition- $transition');
  }

  void _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      List<String> emailErrors = [];
      List<String> passwordErrors = [];

      if (!emailRegex.hasMatch(email)) {
        emailErrors.add('Invalid email format');
      }
      if (password.length < 6) {
        passwordErrors.add('Password length should be at least 6 characters');
      }
      if (emailErrors.isNotEmpty || passwordErrors.isNotEmpty) {
        String errorMessage =
            emailErrors.isNotEmpty ? emailErrors.first : passwordErrors.first;
        emit(AuthFailure(
          error: errorMessage,
          emailErrors: emailErrors,
          passwordErrors: passwordErrors,
        ));
        return;
      }

      await Future.delayed(const Duration(seconds: 2), () {
        return emit(AuthSuccess(uid: '$email-$password'));
      });
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  void _onAuthLogOutRequest(
      AuthLogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  // void _onClearEmailErrors(ClearEmailErrors event, Emitter<AuthState> emit) {
  //   if (state is AuthFailure) {
  //     emit((state as AuthFailure).copyWith(
  //       emailErrors: [],
  //     ));
  //   }
  // }

  // void _onClearPasswordErrors(
  //     ClearPasswordErrors event, Emitter<AuthState> emit) {
  //   if (state is AuthFailure) {
  //     emit((state as AuthFailure).copyWith(
  //       passwordErrors: [],
  //     ));
  //   }
  // }
  void _onClearEmailErrors(ClearEmailErrors event, Emitter<AuthState> emit) {
    if (state is AuthFailure) {
      emit(AuthFailure(
        error: '',
        emailErrors: [],
        passwordErrors: (state as AuthFailure).passwordErrors,
      ));
    } else if (state is AuthInitial || state is AuthLoading) {
      emit(AuthFailure(
        error: '',
        emailErrors: [],
        passwordErrors: [],
      ));
    }
  }

  void _onClearPasswordErrors(
      ClearPasswordErrors event, Emitter<AuthState> emit) {
    if (state is AuthFailure) {
      emit(AuthFailure(
        error: '',
        emailErrors: (state as AuthFailure).emailErrors,
        passwordErrors: [],
      ));
    } else if (state is AuthInitial || state is AuthLoading) {
      emit(AuthFailure(
        error: '',
        emailErrors: [],
        passwordErrors: [],
      ));
    }
  }
}
