import 'package:flutter/material.dart';
import 'package:mvvm_example/models/todo/todo.dart';
import 'package:mvvm_example/transmitters/todo_transmitter.dart';
import 'package:mvvm_example/view_models/todo_view_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoViewModel todoViewModel =
        TodoTransmitter.of(context).todoViewModel;

    return FutureBuilder(
      future: todoViewModel.all(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Ошибка при загрузке данных :("),
          );
        } else {
          final List<Todo> todos = todoViewModel.todos;

          if (todos.isEmpty) {
            return const Center(
              child: Text("У вас пока нет дел :("),
            );
          } else {
            return ListenableBuilder(
              listenable: todoViewModel,
              builder: (BuildContext context, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            final flags = todoViewModel.completedStates[index];
                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                          value: flags.first,
                                          onChanged: (value) {
                                            flags.first = value!;
                                            todoViewModel.updateUi();
                                          }),
                                      Text(todos[index].title),
                                      IconButton(
                                        onPressed: () {
                                          flags.last = !flags.last;
                                          todoViewModel.updateUi();
                                        },
                                        icon: Icon(flags.last
                                            ? Icons.keyboard_arrow_right
                                            : Icons.keyboard_arrow_down),
                                      )
                                    ],
                                  ),
                                  flags.last
                                      ? Column(
                                          children: [
                                            Text("Описание: ${todos[index].desc}"),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Text("status: ${todos[index].status}"),
                                          ],
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      todoViewModel.completedStates
                              .where((element) => element.first == true)
                              .isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    todoViewModel.markDone();
                                  },
                                  child: const Text("Its done!"),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    todoViewModel.deleteAll();
                                  },
                                  child: const Text("Delete!"),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
