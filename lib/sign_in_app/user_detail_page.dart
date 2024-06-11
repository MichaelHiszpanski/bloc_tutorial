import 'package:bloc_tutorial/sign_in_app/bloc/auth_bloc.dart';
import 'package:bloc_tutorial/sign_in_app/components/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state as AuthSuccess;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Success state ${authState.uid}"),
            const SizedBox(
              height: 20.0,
            ),
            GradientButton(
              onPressed: () {},
              buttonName: "Log Out",
            )
          ],
        ),
      ),
    );
  }
}
