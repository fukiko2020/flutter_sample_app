import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_app/todo_add.dart';
import 'package:flutter_sample_app/todo_detail.dart';
import 'package:flutter_sample_app/todo_list.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyTodoApp(),
    ),
  );
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
        '/detail': (context) => const TodoDetailPage(),
        '/add': (context) => const TodoAddPage(),
      },
    );
  }
}
