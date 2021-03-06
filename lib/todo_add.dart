import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_app/providers.dart';

class TodoAddPage extends ConsumerStatefulWidget {
  const TodoAddPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends ConsumerState<TodoAddPage> {
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
                    formValue['title'] = value.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'タイトルを入力してください。';
                    } else if (value.length > 30) {
                      return 'タイトルは30文字以内で入力してください。';
                    }
                    return null;
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
                    alignLabelWithHint: true,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 8,
                  onSaved: (value) {
                    formValue['content'] = value.toString();
                  },
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? '内容を入力してください。'
                        : null;
                  },
                ),
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();
                      ref.read(todoProvider).addTodoItem(formValue);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Todo を追加'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
