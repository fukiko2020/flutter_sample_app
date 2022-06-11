import 'package:flutter/material.dart';

class TodoDetailPage extends StatefulWidget {
    const TodoDetailPage({
        Key? key,
        required this.index,
        required this.todoItem,
        required this.toggleIsCompleted,
    }) : super(key: key);

    final int index;
    final Map todoItem;
    final Function(int) toggleIsCompleted;

    @override
    TodoDetailPageState createState() => TodoDetailPageState();
}

class TodoDetailPageState extends State<TodoDetailPage> {
    bool currentIsCompleted = false;

    @override
    void initState() {
        super.initState();
        currentIsCompleted = widget.todoItem['isCompleted'];
    }

    void setCurrentIsCompleted() {
        setState(() {
            currentIsCompleted = !currentIsCompleted;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Todo 詳細'),
            ),
            body: Column(
                children: <Widget>[
                    const Text('タイトル'),
                    Text('${widget.todoItem['title']}'),
                    const Text('内容'),
                    Text(widget.todoItem['content']),
                    ElevatedButton(
                        onPressed: () {
                            widget.toggleIsCompleted(widget.index);
                            setCurrentIsCompleted();
                        },
                        child: currentIsCompleted
                        ? const Text('未完了にする')
                        : const Text('完了にする'),
                    ),
                ],
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
                // onTap: _onBottomBarTapped,
            ),
        );
    }
}
