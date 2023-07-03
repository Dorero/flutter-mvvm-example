import 'package:test_riverpod/models/todo/todo.dart';
import 'package:test_riverpod/repositories/todo_repository.dart';
import 'package:test_riverpod/view_models/view_model.dart';

class TodoViewModel extends ViewModel {
  final TodoRepository _todoRepository = TodoRepository();
  late List<Todo> todos = [];

  TodoViewModel() {
    _todoRepository.all().then((v) => todos = v);
  }

  void create(String title, String desc, String status) {
    _todoRepository.create(title, desc, status);
    notifyListeners();
  }

  void delete(int id) {
    _todoRepository.delete(id);
    notifyListeners();
  }

  void updateUi() {
    notifyListeners();
  }
}
