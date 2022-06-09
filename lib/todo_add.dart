import 'package:flutter/material.dart';

class TodoAddPage extends StatelessWidget {
    const TodoAddPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Todo 追加'),
            ),
            body: Container(
                child: const Text('Todo 追加画面'),
            ),
        );
    }
}
