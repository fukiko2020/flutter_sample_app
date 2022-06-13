import 'package:flutter/material.dart';

class TodoAddPage extends StatefulWidget {
    const TodoAddPage({Key? key, required this.addTodoItem}) : super(key: key);

    final void Function(Map<String, String>) addTodoItem;

    @override
    TodoAddPageState createState() => TodoAddPageState();
}

class TodoAddPageState extends State<TodoAddPage> {
    final formKey = GlobalKey<FormState>();
    Map<String, String> formValue = {};

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Todo 追加'),
            ),
            body: Form(
                key: formKey,
                child: Center(
                    child: Container(
                        width: 300,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 32.0),
                                    padding: const EdgeInsets.all(4.0),
                                    width: 300,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'タイトル',
                                        ),
                                        onSaved: (value) {
                                            formValue['title']
                                            = value.toString();
                                        },
                                        validator: (value) {
                                            return (
                                                value != null
                                                && value.length <= 30)
                                                ? 'タイトルは30文字以内で入力してください。'
                                                : null;
                                        },
                                    ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(bottom: 32.0),
                                    padding: const EdgeInsets.all(4.0),
                                    width: 300,
                                    height: 200,
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '内容',
                                            // labelTextを上寄せにする
                                            alignLabelWithHint: true,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 8,
                                        onSaved: (value) {
                                            formValue['content']
                                            = value.toString();
                                        },
                                    ),
                                ),
                                SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () {
                                            formKey.currentState?.save();
                                            widget.addTodoItem(formValue);
                                            Navigator.of(context).pop();
                                        },
                                        child: const Text('Todo を追加'),
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            )
        );
    }
}
