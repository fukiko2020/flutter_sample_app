import 'package:flutter/material.dart';
import 'package:flutter_sample_app/todo_item.dart';

class TodoDetailPage extends StatefulWidget {
  const TodoDetailPage({
    Key? key,
    required this.index,
    required this.todoItem,
    required this.changeShownList,
    required this.toggleIsCompleted,
  }) : super(key: key);

  final int index;
  final TodoItem todoItem;
  final Function(int) changeShownList;
  final Function(int) toggleIsCompleted;

  @override
  TodoDetailPageState createState() => TodoDetailPageState();
}

class TodoDetailPageState extends State<TodoDetailPage> {
  bool currentIsCompleted = false;

  @override
  void initState() {
    super.initState();
    currentIsCompleted = widget.todoItem.isCompleted;
  }

  void setCurrentIsCompleted() {
    setState(
      () {
        currentIsCompleted = !currentIsCompleted;
      },
    );
  }

  void backToTodoList(int index) {
    widget.changeShownList(index);
    Navigator.of(context).pop();
  }

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
                  child: Text(widget.todoItem.title),
                )
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
                  child: Text(widget.todoItem.content),
                )
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    widget.toggleIsCompleted(widget.index);
                    setCurrentIsCompleted();
                  },
                  child: currentIsCompleted
                      ? const Text('未完了にする')
                      : const Text('完了にする'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.unpublished),
            label: '未完了',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: '完了',
          ),
        ],
        onTap: backToTodoList,
      ),
    );
  }
}
