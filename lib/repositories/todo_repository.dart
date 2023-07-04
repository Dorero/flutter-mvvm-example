import 'package:test_riverpod/storages/local_storage.dart';
import 'package:test_riverpod/models/todo/todo.dart';

class TodoRepository {
  final LocalStorage _localStorage = LocalStorage();

  create(String title, String desc, String status) {
    _localStorage.create(title, desc, status);
  }

  Future<List<Todo>> all() {
    return _localStorage.all();
  }

  delete(int id) {
    _localStorage.delete(id);
  }

  deleteAll(List<int> indexes) {
    _localStorage.deleteAll(indexes);
  }
}
