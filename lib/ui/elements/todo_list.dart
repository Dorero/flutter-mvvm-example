import 'package:flutter/material.dart';
import 'package:test_riverpod/models/todo/todo.dart';
import 'package:test_riverpod/transmitters/todo_transmitter.dart';
import 'package:test_riverpod/view_models/todo_view_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoViewModel todoViewModel =
        TodoTransmitter.of(context).todoViewModel;

    return ListenableBuilder(
      listenable: todoViewModel,
      builder: (BuildContext context, Widget? child) {
        final List<Todo> todos = todoViewModel.todos;
        if (todos.isEmpty) {
          return const Center(
            child: Text("У вас пока нет дел :("),
          );
        } else {
          return ListView.builder(
            itemCount: todoViewModel.todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(todoViewModel.todos[index].title);
            },
          );
        }
      },
    );
  }
}
