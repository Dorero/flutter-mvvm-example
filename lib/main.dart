import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_riverpod/models/todo/todo.dart';
import 'app.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  runApp(const App());
}



