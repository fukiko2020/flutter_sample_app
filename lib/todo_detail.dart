import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_app/todo_list.dart';

class TodoDetailPage extends ConsumerStatefulWidget {
  const TodoDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends ConsumerState<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments! as int;
    final detailItem = ref.read(detailItemProvider);
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
                  child: Text(detailItem.title),
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
                  child: Text(detailItem.content),
                ),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(todoProvider).replaceTodoItem(index);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    detailItem.isCompleted ? '未完了にする' : '完了にする',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
