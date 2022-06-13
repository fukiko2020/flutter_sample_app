import 'package:flutter/material.dart';
import 'package:flutter_sample_app/todo_add.dart';
import 'package:flutter_sample_app/todo_detail.dart';
import 'package:flutter_sample_app/todo_item.dart';

// 一覧ページ用ウィジェット
class TodoListPage extends StatefulWidget {
    const TodoListPage({Key? key}) : super(key: key);

    @override
    TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State {
    bool showIsCompletedList = false;  // 現在のタブは未完了リストか完了リストか
    int bottomBarIndex = 0;  // 選択されたタブを管理するための変数
    List<TodoItem> unCompletedList = [
        TodoItem(
            id: 0,
            title: 'Flutter',
            content: 'Flutter を勉強する',
            isCompleted: false,
        ),
        TodoItem(
            id: 1,
            title: '買い物',
            content: '卵を買う',
            isCompleted: false,
        ),
    ];

    List<TodoItem> completedList = [
        TodoItem(
            id: 2,
            title: '課題',
            content: '月 3 レポート',
            isCompleted: true,
        ),
    ];

    List<TodoItem> shownList = [];

    @override
    void initState() {
        super.initState();
        shownList = unCompletedList;
    }

    // ボトムバーがタップされたら setState を実行
    void changeShownList(int index) {
        setState(() {
            bottomBarIndex = index;
            shownList = bottomBarIndex == 0
                        ? unCompletedList
                        : completedList;
        });
    }

    void toggleIsCompleted(int index) {
        final prevIsCompleted = shownList[index].isCompleted;
        setState(() {
            shownList[index].isCompleted = !shownList[index].isCompleted;
            if (prevIsCompleted) {  // toggle 前が完了済みなら未完了リストに追加、完了リストから削除
                unCompletedList.add(shownList[index]);
                completedList.removeAt(index);
            } else {  // toggle 前が未完了なら完了リストに追加、未完了リストから削除
                completedList.add(shownList[index]);
                unCompletedList.removeAt(index);
            }
        });
    }

    void addTodoItem(Map<String, String> formValue) {
        setState(() {
            unCompletedList.add(
                TodoItem(
                    id: unCompletedList.length + completedList.length,
                    title: formValue['title']!,
                    content: formValue['content']!,
                    isCompleted: false,
            ));
        });
    }

    void toDetailPage(int index) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
                return TodoDetailPage(
                    index: index,
                    todoItem: shownList[index],
                    changeShownList: changeShownList,
                    toggleIsCompleted: toggleIsCompleted,
                );
            }),
        );
    }

    void toAddPage() {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
                return TodoAddPage(addTodoItem: addTodoItem);
            }),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('ToDo 一覧（完了済み ${completedList.length} / ${unCompletedList.length + completedList.length}）'),
            ),
            body: Center(
                child: ListView.builder(
                    itemCount: shownList.length,
                    itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                                title: Text(
                                    '${index + 1}  ${shownList[index].title}'
                                ),
                                trailing: Checkbox(
                                    activeColor: Colors.green,
                                    checkColor: Colors.white,
                                    onChanged: (value) {
                                        toggleIsCompleted(index);
                                    },
                                    value: shownList[index].isCompleted,
                                ),
                                onTap: () => {toDetailPage(index)},
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
                onTap: changeShownList,
                currentIndex: bottomBarIndex,
                selectedItemColor: Colors.blue,
            )
        );
    }
}
