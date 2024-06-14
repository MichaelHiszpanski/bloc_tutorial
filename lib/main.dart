import 'package:bloc_tutorial/home_page.dart';
import 'package:bloc_tutorial/utils/app_bloc_observer.dart';
import 'package:bloc_tutorial/utils/app_repositories/app_repositories.dart';
import 'package:bloc_tutorial/utils/app_routes/app_routes.dart';
import 'package:bloc_tutorial/utils/bloc_provider/bloc_provider.dart';
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
    return AppRepositories(
      child: AppBlocProviders(
          child: MaterialApp(
        title: "Block Tutorial",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true),
        home: const HomePage(title: "Home Page"),
        routes: AppRoutes.routes,
      )),
    );
  }
}
