class TodoItem {
  final int id;
  final String title;
  final String content;
  bool isCompleted;
  void toggleIsCompleted() => isCompleted = !isCompleted;

  TodoItem({
      required this.id,
      required this.title,
      required this.content,
      required this.isCompleted
  });
}
