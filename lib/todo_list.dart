import 'package:flutter/material.dart';

// 一覧ページ用ウィジェット
class TodoListPage extends StatelessWidget {
    const TodoListPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return const Scaffold(
            body: Center(
                child: Text('リスト一覧画面'),
            ),
        );
    }
}
