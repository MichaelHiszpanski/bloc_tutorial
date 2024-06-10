import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/to_do_list_app/models/todo_model.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());
  void loadTodos(List<ToDo> todos) {
    emit(TodoLoaded(todos));
  }

  void addTodo(ToDo todo) {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(TodoLoaded(List.from(currentState.todos)..add(todo)));
    }
  }

  void removeTodo(ToDo todo) {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(TodoLoaded(List.from(currentState.todos)..remove(todo)));
    }
  }
}
