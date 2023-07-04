import 'package:mvvm_example/models/todo/todo.dart';
import 'package:mvvm_example/repositories/todo_repository.dart';
import 'package:mvvm_example/view_models/view_model.dart';

class TodoViewModel extends ViewModel {
  final TodoRepository _todoRepository = TodoRepository();
  List<Todo> todos = [];
  List<List<bool>> completedStates = [];

  void create(String title, String desc, String status) {
    _todoRepository.create(title, desc, status);
    notifyListeners();
  }

  void delete(int id) {
    _todoRepository.delete(id);
    notifyListeners();
  }

  void deleteAll() {
    final List<int> indexes = [];
    List<List<bool>> newStates = [];

    completedStates.asMap().forEach((index, states) {
      if (states.first) {
        indexes.add(index);
      } else {
        newStates.add([false, states.last]);
      }
    });

    completedStates = newStates;

    _todoRepository.deleteAll(indexes);
    notifyListeners();
  }

  void updateUi() {
    notifyListeners();
  }

  Future<List<Todo>> all() async {
    todos = await _todoRepository.all();
    completedStates = List.generate(todos.length, (index) => [false, false]);
    notifyListeners();
    return todos;
  }

  void markDone() {
    completedStates.asMap().forEach((index, states) {
      if (states.first) {
        todos[index].status = "done";
      }
    });
    notifyListeners();
  }
}
