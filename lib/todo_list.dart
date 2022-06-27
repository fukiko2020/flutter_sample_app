import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_app/todo_item.dart';

final todoProvider = ChangeNotifierProvider((ref) => TodoListNotifier());
final detailItemProvider = StateProvider<TodoItem>(
  (ref) => TodoItem(id: 0, title: '', content: '', isCompleted: false),
);

class TodoListNotifier extends ChangeNotifier {
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

  void changeBottomBarIndex(int index) {
    bottomBarIndex = index;
    notifyListeners();
  }

  void addTodoItem(Map<String, String> formValue) {
    _unCompletedList.add(
      TodoItem(
        id: _unCompletedList.length + _completedList.length,
        title: formValue['title']!,
        content: formValue['content']!,
        isCompleted: false,
      ),
    );
    notifyListeners();
  }

  void replaceTodoItem(int index) {
    final tappedItem = shownList[index];
    final removeFrom =
        tappedItem.isCompleted ? _completedList : _unCompletedList;
    final addTo = tappedItem.isCompleted ? _unCompletedList : _completedList;
    addTo.add(tappedItem..toggleIsCompleted());
    removeFrom.removeAt(index);
    notifyListeners();
  }
}

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'ToDo 一覧（完了済み ${todo._completedList.length} / ${todo._unCompletedList.length + todo._completedList.length}）'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todo.shownList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('${index + 1}  ${todo.shownList[index].title}'),
                trailing: Checkbox(
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    todo.replaceTodoItem(index);
                  },
                  value: todo.shownList[index].isCompleted,
                ),
                onTap: () {
                  ref
                      .read(detailItemProvider.state)
                      .update((state) => todo.shownList[index]);
                  Navigator.of(context).pushNamed(
                    '/detail',
                    arguments: index,
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/add',
          );
        },
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
        onTap: todo.changeBottomBarIndex,
        currentIndex: todo.bottomBarIndex,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
