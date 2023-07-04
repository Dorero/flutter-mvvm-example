import 'package:flutter/material.dart';
import 'package:mvvm_example/transmitters/todo_transmitter.dart';
import 'package:mvvm_example/ui/elements/todo_list.dart';
import 'package:mvvm_example/view_models/todo_view_model.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TodoViewModel todoViewModel = TodoViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Дела"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/todo/new"),
        child: const Icon(Icons.add),
      ),
      body: TodoTransmitter(
        todoViewModel: todoViewModel,
        child: const TodoList(),
      ),
    );
  }
}
