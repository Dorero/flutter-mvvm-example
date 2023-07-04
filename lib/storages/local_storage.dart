import 'package:hive/hive.dart';
import 'package:test_riverpod/models/todo/todo.dart';

class LocalStorage {
  create(String title, String desc, String status) async {
    final box = Hive.box("todos");
    List<Todo> todos = box.get("todos", defaultValue: []).cast<Todo>();

    todos.add(Todo(title: title, desc: desc, status: status));
    box.put("todos", todos);
  }

  Future<List<Todo>> all() async {
    var box = await Hive.openBox("todos");
    return box.get("todos", defaultValue: []).cast<Todo>();
  }

  delete(int index) async {
    Hive.box("todos").deleteAt(index);
  }

  deleteAll(List<int> indexes) {
    final box = Hive.box("todos");
    final List<Todo> todos = box.get("todos").cast<Todo>();

    for (var index in indexes) {
      todos.removeAt(index);
    }
    box.put("todos", todos);
  }
}
