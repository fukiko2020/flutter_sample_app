import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_app/providers.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'ToDo 一覧（完了済み ${todo.completedList.length} / ${todo.unCompletedList.length + todo.completedList.length}）'),
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
