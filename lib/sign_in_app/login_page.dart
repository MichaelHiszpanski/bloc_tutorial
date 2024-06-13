import 'package:bloc_tutorial/components/custom_text_input.dart';
import 'package:bloc_tutorial/home_page.dart';
import 'package:bloc_tutorial/sign_in_app/bloc/auth_bloc.dart';
import 'package:bloc_tutorial/sign_in_app/components/gradient_button.dart';
import 'package:bloc_tutorial/sign_in_app/components/login_field.dart';
import 'package:bloc_tutorial/sign_in_app/components/social_button.dart';
import 'package:bloc_tutorial/sign_in_app/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  List<String> emailErrors = [];
  List<String> passwordErrors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.uid)));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const UserDetail()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign in.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const SocialButton(
                      iconPath: 'assets/svg/g_logo.svg',
                      label: 'Continue with Google'),
                  const SizedBox(height: 20),
                  const SocialButton(
                    iconPath: 'assets/svg/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 20),
                  CustomTextInput(
                    hintText: 'Email',
                    controller: emailController,
                    errorMessages:
                        state is AuthFailure ? state.emailErrors : [],
                    onFocus: () {
                      context.read<AuthBloc>().add(ClearEmailErrors());
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextInput(
                    hintText: 'Password',
                    controller: passwordController,
                    errorMessages:
                        state is AuthFailure ? state.passwordErrors : [],
                    onFocus: () {
                      context.read<AuthBloc>().add(ClearPasswordErrors());
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLoginRequested(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()));
                    },
                    buttonName: "Sign In",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
