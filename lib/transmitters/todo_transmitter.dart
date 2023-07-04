import 'package:flutter/material.dart';
import 'package:mvvm_example/view_models/todo_view_model.dart';

class TodoTransmitter extends InheritedWidget {
  final TodoViewModel todoViewModel;

  const TodoTransmitter(
      {super.key, required this.todoViewModel, required super.child});

  @override
  bool updateShouldNotify(TodoTransmitter oldWidget) {
    return oldWidget.todoViewModel.todos != todoViewModel.todos;
  }

  static TodoTransmitter of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }
}
