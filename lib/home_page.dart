import 'package:bloc_tutorial/bloc/counter_bloc.dart';
import 'package:bloc_tutorial/cubit/counter_cubit.dart';
import 'package:bloc_tutorial/components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Hello World Home Page"),
            BlocBuilder<CounterBloc, CounterState>(builder: (context, counter) {
              return Text("Counter is ${counter.count}");
            })
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () => counterBloc.add(CounterIncrement()),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => counterBloc.add(CounterDecrement()),
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),
        // FloatingActionButton(
        //   onPressed: () => counterCubit.increment(),
        //   tooltip: 'Increment (Cubit)',
        //   child: const Icon(Icons.add),
        // ),
        // const SizedBox(height: 8),
        // FloatingActionButton(
        //   onPressed: () => counterCubit.decrement(),
        //   tooltip: 'Decrement (Cubit)',
        //   child: const Icon(Icons.remove),
        // ),
      ]),
      bottomNavigationBar: BottomBar(title: "Bottom Bar", indexValue: 1),
    );
  }
}
