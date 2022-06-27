import 'package:flutter/material.dart';
import 'package:flutter_sample_app/todo_item.dart';

class TodoDetailArguments {
  final int index;
  final TodoItem todoItem;
  final Function(int) replaceTodoItem;

  TodoDetailArguments(this.index, this.todoItem, this.replaceTodoItem);
}

class TodoDetailPage extends StatelessWidget {
  final int index;
  final TodoItem todoItem;
  final Function(int) replaceTodoItem;

  const TodoDetailPage({
    Key? key,
    required this.index,
    required this.todoItem,
    required this.replaceTodoItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 詳細'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 4.0),
                child: const Text('タイトル'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  width: 300,
                  child: Text(todoItem.title),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: const Text('内容'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 300,
                  height: 200,
                  child: Text(todoItem.content),
                ),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    replaceTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: todoItem.isCompleted
                      ? const Text('未完了にする')
                      : const Text('完了にする'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
