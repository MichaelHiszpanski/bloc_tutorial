part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<ToDo> todos;

  TodoLoaded(this.todos);
}
