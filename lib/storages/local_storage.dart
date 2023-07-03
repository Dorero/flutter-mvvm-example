import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_riverpod/models/todo/todo.dart';

class LocalStorage {
  final Future<Isar> isar;

  LocalStorage() : isar = initIsar();

  create(String title, String desc, String status) async {
    isar.then((i) {
      i.writeTxn(() async {
        i.todos.put(Todo(title: title, desc: desc, status: status));
      });
    });
  }

  Future<List<Todo>> all() async {
    final inst = await isar;
    print(22);

    return await inst.todos.where().findAll();
  }

  delete(int id) async {
    isar.then((i) => i.todos.delete(id));
  }

  static Future<Isar> initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    print(22);
    return Isar.open([TodoSchema], directory: dir.path);
  }
}
