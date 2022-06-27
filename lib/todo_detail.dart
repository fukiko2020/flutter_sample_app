import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_app/todo_item.dart';

// class TodoDetailArguments {
//   final int index;
//   final TodoItem todoItem;
//   final Function(int) toggleIsCompleted;

//   TodoDetailArguments(this.index, this.todoItem, this.toggleIsCompleted);
// }

// class TodoDetailPage extends StatefulWidget {
//   final int index;
//   final TodoItem todoItem;
//   final Function(int) toggleIsCompleted;

//   const TodoDetailPage({
//     Key? key,
//     required this.index,
//     required this.todoItem,
//     required this.toggleIsCompleted,
//   }) : super(key: key);

//   @override
//   TodoDetailPageState createState() => TodoDetailPageState();
// }
final isCompletedProvider = StateProvider<bool>((ref) => false);

class TodoDetailPage extends ConsumerStatefulWidget {
  const TodoDetailPage({Key? key}) : super(key: key);

  @Override
  ConsumerState<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends ConsumerState<TodoDetailPage> {
  const TodoDetailPage({Key? key}) : super(key: key);

  bool _currentIsCompleted = false;

  @override
  void initState() {
    super.initState();
    _currentIsCompleted = ref.read(todoItemProvider);
  }

  // void setCurrentIsCompleted() {
  //   setState(
  //     () {
  //       currentIsCompleted = !currentIsCompleted;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 詳細'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 4.0),
                child: const Text('タイトル'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  width: 300,
                  child: Text(widget.todoItem.title),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: const Text('内容'),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 300,
                  height: 200,
                  child: Text(widget.todoItem.content),
                ),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: Consumer(
                  // 子の中だけ再描画する
                  builder: (context, ref, child) => ElevatedButton(
                    onPressed: () {
                      widget.toggleIsCompleted(widget.index);
                      // setCurrentIsCompleted();
                      ref
                          .read(isCompletedProvider.state)
                          .update((state) => !state);
                    },
                    // ここは再描画したいので watch() を使用
                    child: ref.watch(isCompletedProvider)
                        ? const Text('未完了にする')
                        : const Text('完了にする'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
