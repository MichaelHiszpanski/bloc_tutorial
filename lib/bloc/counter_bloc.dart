import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part "counter_event.dart";
part "counter_state.dart";

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState()) {
    on<CounterIncrement>((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    });
    on<CounterDecrement>((event, emit) {
      if (state.count == 0) {
        return;
      }
      emit(state.copyWith(count: state.count - 1));
    });
  }
}
