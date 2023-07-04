import 'package:flutter/material.dart';
import 'package:mvvm_example/transmitters/todo_transmitter.dart';
import 'package:mvvm_example/view_models/todo_view_model.dart';

class NewTodo extends StatelessWidget {
  NewTodo({super.key});

  final TodoViewModel todoViewModel = TodoViewModel();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    String selectedStatus = "done";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Новое дело!"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: TodoTransmitter(
          todoViewModel: todoViewModel,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Заголовок"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: descController,
                minLines: 3,
                maxLines: 10,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Описание"),
              ),
              const SizedBox(
                height: 30,
              ),
              ListenableBuilder(
                listenable: todoViewModel,
                builder: (BuildContext context, Widget? child) {
                  return DropdownButton(
                    value: selectedStatus,
                    items: const [
                      DropdownMenuItem(
                        value: 'done',
                        child: Text('Готово'),
                      ),
                      DropdownMenuItem(
                        value: 'not_done',
                        child: Text('Не готово'),
                      ),
                      DropdownMenuItem(
                        value: 'in_progress',
                        child: Text('В процессе'),
                      ),
                    ],
                    onChanged: (status) {
                      selectedStatus = status.toString();
                      todoViewModel.updateUi();
                    },
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  todoViewModel.create(titleController.text,
                      descController.text, selectedStatus);
                  Navigator.pushNamed(context, "/");
                },
                child: const Text("Создать"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
