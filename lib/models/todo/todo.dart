import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
   String title;

  @HiveField(1)
   String desc;

  @HiveField(2)
   String status;

  Todo({required this.title, required this.desc, required this.status});
}
