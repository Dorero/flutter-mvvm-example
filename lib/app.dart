import 'package:flutter/material.dart';
import 'ui/screens/home.dart';
import 'ui/screens/new_todo.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/todo/new": (context) => NewTodo(),
      },
    );
  }
}
