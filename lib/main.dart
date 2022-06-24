import 'package:flutter/material.dart';
import 'package:flutter_sample_app/todo_add.dart';
import 'package:flutter_sample_app/todo_detail.dart';
import 'package:flutter_sample_app/todo_list.dart';

void main() {
  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TodoListPage(),
        '/add': (context) => const TodoAddPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final args = settings.arguments as TodoDetailArguments;
          return MaterialPageRoute(builder: (context) {
            return TodoDetailPage(
              index: args.index,
              todoItem: args.todoItem,
              toggleIsCompleted: args.toggleIsCompleted,
            );
          });
        }
      },
    );
  }
}
