import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_tutorial/bloc/counter_bloc.dart';
import 'package:bloc_tutorial/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/sign_in_app/bloc/auth_bloc.dart';
import 'package:bloc_tutorial/to_do_list_app/cubit/todo_cubit.dart';
import 'package:bloc_tutorial/weather_app/bloc/weather_bloc.dart';
import 'package:bloc_tutorial/weather_app/data/repository/weather_repository.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => TodoCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (context) => WeatherBloc(context.read<WeatherRepository>()),
        ),
      ],
      child: child,
    );
  }
}
