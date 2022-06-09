import 'package:flutter/material.dart';

class TodoDetailPage extends StatelessWidget {
    const TodoDetailPage({Key? key, required this.todoItem}) : super(key: key);

    final Map todoItem;


    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Todo 詳細'),
            ),
            body: Container(
                child: Text('${todoItem['title']}'),
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
