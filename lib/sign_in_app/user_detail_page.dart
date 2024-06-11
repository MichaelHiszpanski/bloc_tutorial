import 'package:bloc_tutorial/sign_in_app/bloc/auth_bloc.dart';
import 'package:bloc_tutorial/sign_in_app/components/gradient_button.dart';
import 'package:bloc_tutorial/sign_in_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              children: [
                Text("Success state ${(state as AuthSuccess).uid}"),
                const SizedBox(
                  height: 20.0,
                ),
                GradientButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogOutRequested());
                  },
                  buttonName: "Log Out",
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
