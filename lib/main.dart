import 'package:bloc_tutorial/bloc/counter_bloc.dart';
import 'package:bloc_tutorial/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/home_page.dart';
import 'package:bloc_tutorial/sign_in_app/app_bloc_observer.dart';
import 'package:bloc_tutorial/sign_in_app/bloc/auth_bloc.dart';
import 'package:bloc_tutorial/sign_in_app/login_page.dart';
import 'package:bloc_tutorial/sign_in_app/user_detail_page.dart';
import 'package:bloc_tutorial/to_do_list_app/add_todo_page.dart';
import 'package:bloc_tutorial/to_do_list_app/cubit/todo_cubit.dart';
import 'package:bloc_tutorial/to_do_list_app/todo_list.dart';
import 'package:bloc_tutorial/weather_app/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CounterCubit()),
          BlocProvider(create: (_) => CounterBloc()),
          BlocProvider(create: (_) => TodoCubit()),
          BlocProvider(create: (_) => AuthBloc()),
        ],
        child: MaterialApp(
          title: "Block Tutorial",
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true),
          home: const HomePage(title: "Home Page"),
          routes: {
            '/to_do_list_app/todo_list': (_) => const TodoList(),
            '/to_do_list_app/add_todo_page': (_) => const AddTodoPage(),
            '/home_page': (_) => const HomePage(title: "Home Page"),
            '/sign_in_app/login_page': (_) => const LoginScreen(),
            '/sign_in_app/user_detail': (_) => const UserDetail(),
            '/weather_app/weather_page': (_) => WeatherPage()
          },
        ));
  }
}
