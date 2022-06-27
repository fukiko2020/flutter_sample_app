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
      bottomBarIndex == 0 ? unCompletedList : completedList;

  final List<TodoItem> unCompletedList = [
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

  final List<TodoItem> completedList = [
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
    unCompletedList.add(
      TodoItem(
        id: unCompletedList.length + completedList.length,
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
        tappedItem.isCompleted ? completedList : unCompletedList;
    final addTo = tappedItem.isCompleted ? unCompletedList : completedList;
    addTo.add(tappedItem..toggleIsCompleted());
    removeFrom.removeAt(index);
    notifyListeners();
  }
}
