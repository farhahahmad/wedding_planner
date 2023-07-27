// This code defines a ToDoModel class with properties representing checklist to do items information

class ToDoModel {
  String? id;
  String? task;
  bool isDone;

  ToDoModel({
    required this.id,
    required this.task,
    required this.isDone
  });
}