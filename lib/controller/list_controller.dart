import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:wedding_planner/model/guest_model.dart';
import 'package:wedding_planner/model/todo.dart';

class ListController extends ControllerMVC {

  factory ListController() {
    _this ??= ListController._();
    return _this!;
  }
  static ListController? _this;

  ListController._();

  void updateTodo(ToDoModel todo) {
    FirebaseFirestore.instance.collection("todo").doc(todo.id).update({
      "isDone" : !todo.isDone
    });
  }

  void deleteTodo(ToDoModel todo) {
    FirebaseFirestore.instance.collection("todo").doc(todo.id).delete();
  }

  void addTodo(String toDo) {
    FirebaseFirestore.instance.collection("todo").add({
      "task" : toDo, "isDone" : false
    });
    // _todoController.clear();
  }

  void updateGuest(GuestModel guest) {
    FirebaseFirestore.instance.collection("guest").doc(guest.id).update({
      "isDone" : !guest.isDone
    });
  }

  void deleteGuest(GuestModel guest) {
    FirebaseFirestore.instance.collection("guest").doc(guest.id).delete();
  }

  void addGuest(String name, String address) {
    FirebaseFirestore.instance.collection("guest").add({
      "name" : name, "address" : address, "isDone" : false
    });
  }
}