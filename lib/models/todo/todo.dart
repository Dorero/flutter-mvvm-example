import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;

  final String title;
  final String desc;
  final String status;

  Todo({required this.title, required this.desc, required this.status});
}
