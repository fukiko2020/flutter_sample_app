import 'package:flutter/material.dart';
import 'package:flutter_sample_app/todo_detail.dart';
import 'package:flutter_sample_app/todo_item.dart';

// 一覧ページ用ウィジェット
class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  TodoListPageState createState() => TodoListPageState();
}

class TodoListPageState extends State {
  int bottomBarIndex = 0; // 選択されたタブを管理するための変数
  List<TodoItem> get shownList =>
      bottomBarIndex == 0 ? _unCompletedList : _completedList;
  final List<TodoItem> _unCompletedList = [
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

  final List<TodoItem> _completedList = [
    TodoItem(
      id: 2,
      title: '課題',
      content: '月 3 レポート',
      isCompleted: true,
    ),
  ];

  // ボトムバーがタップされたら setState を実行
  void changeBottomBarIndex(int index) {
    setState(
      () {
        bottomBarIndex = index;
      },
    );
  }

  void toggleIsCompleted(int index) {
    setState(
      () {
        final tappedItem = shownList[index];
        final removeFrom =
            tappedItem.isCompleted ? _completedList : _unCompletedList;
        final addTo =
            tappedItem.isCompleted ? _unCompletedList : _completedList;
        addTo.add(tappedItem..toggleIsCompleted());
        removeFrom.removeAt(index);
      },
    );
  }

  void addTodoItem(Map<String, String> formValue) {
    setState(
      () {
        _unCompletedList.add(
          TodoItem(
            id: _unCompletedList.length + _completedList.length,
            title: formValue['title']!,
            content: formValue['content']!,
            isCompleted: false,
          ),
        );
      },
    );
  }

  void toDetailPage(int index) {
    Navigator.of(context).pushNamed(
      '/detail',
      arguments:
          TodoDetailArguments(index, shownList[index], toggleIsCompleted)
    );
  }

  void toAddPage() {
    Navigator.of(context).pushNamed(
      '/add',
      arguments: addTodoItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'ToDo 一覧（完了済み ${_completedList.length} / ${_unCompletedList.length + _completedList.length}）'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: shownList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('${index + 1}  ${shownList[index].title}'),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.unpublished),
            label: '未完了',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: '完了',
          ),
        ],
        onTap: changeBottomBarIndex,
        currentIndex: bottomBarIndex,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
