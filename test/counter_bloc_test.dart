import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_tutorial/bloc/counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    tearDown(() {
      counterBloc.close();
    });

    test('initial state is CounterState with count 0', () {
      expect(counterBloc.state.count, 0);
    });

    blocTest<CounterBloc, CounterState>(
      'emits [CounterState(count: 1)] when CounterIncrement is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterIncrement()),
      expect: () => [CounterState(count: 1)],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [CounterState(count: 0)] when CounterDecrement is added and count is 1',
      build: () => counterBloc,
      seed: () => CounterState(count: 1),
      act: (bloc) => bloc.add(CounterDecrement()),
      expect: () => [CounterState(count: 0)],
    );

    blocTest<CounterBloc, CounterState>(
      'does not decrement below 0',
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterDecrement()),
      expect: () => [],
    );
  });
}
