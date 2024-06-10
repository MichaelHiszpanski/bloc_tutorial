import 'package:bloc_tutorial/to_do_list_app/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
        if (state is TodoInitial) {
          return const Center(child: Text('No todos yet'));
        } else if (state is TodoLoaded) {
          final todos = state.todos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.name),
              );
            },
          );
        } else {
          return const Center(child: Text('Unknown state'));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/to_do_list_app/add_todo_page');
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
