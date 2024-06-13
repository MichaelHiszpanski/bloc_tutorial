part of 'counter_bloc.dart';

class CounterState extends Equatable {
  int count;
  CounterState({this.count = 0});
  CounterState copyWith({int? count}) {
    return CounterState(count: count ?? this.count);
  }

  @override
  List<Object?> get props => [count];
}
