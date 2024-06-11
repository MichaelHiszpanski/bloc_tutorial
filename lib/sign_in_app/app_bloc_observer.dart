import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Block - $bloc  - ${bloc.runtimeType} Created! State ${bloc.state}');
  }
}
