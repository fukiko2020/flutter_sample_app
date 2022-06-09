import 'package:flutter/material.dart';
import 'package:flutter_sample_app/todo_add.dart';
import 'package:flutter_sample_app/todo_detail.dart';

// 一覧ページ用ウィジェット
class TodoListPage extends StatefulWidget {
    const TodoListPage({Key? key}) : super(key: key);

    @override
    TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State {
    final List<String> showType = ['未完了', '完了'];  // タブの名前を表示するための配列
    int bottomBarIndex = 0;  // 選択されたタブを管理するための変数
    List<Map> todoList = [
        {
            'title': 'Flutter',
            'content': 'Flutter を勉強する',
            'isCompleted': false,
        },
        {
            'title': '買い物',
            'content': '卵を買う',
            'isCompleted': false,
        },
        {
            'title': '課題',
            'content': '月 3 レポート',
            'isCompleted': true,
        },
    ];

    // ボトムバーがタップされたら setState を実行
    void onBottomBarTapped(int index) {
        setState(() {
            bottomBarIndex = index;
        });
    }

    void toDetailPage(int index) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
                return TodoDetailPage(todoItem: todoList[index]);
            }),
        );
    }

    void toAddPage() {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
                return const TodoAddPage();
            }),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('ToDo 一覧'),
            ),
            body: Center(
                child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                                title: Text(
                                    '${index + 1}  ${todoList[index]['title']} ${
                                        todoList[index]['isCompleted']
                                        ? 'true' : 'false'
                                    }'
                                ),
                                onTap: () => { toDetailPage(index)},
                            ),
                        );
                    },
                ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: toAddPage,
                child: const Icon(Icons.add),
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
                onTap: onBottomBarTapped,
                currentIndex: bottomBarIndex,
                selectedItemColor: Colors.blue.shade900,
            )
        );
    }
}
