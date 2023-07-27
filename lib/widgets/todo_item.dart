import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDoModel todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: HexColor("#489363"),
        ),
        title: Text(
          todo.task!,
          style: TextStyle(
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            fontSize: 15
          ),
        ),
        // trailing: IconButton(
        //   color: HexColor("#B69EA2"),
        //   iconSize: 18,
        //   icon: Icon(Icons.delete),
        //   onPressed: () {
        //     onDeleteItem(todo.id);
        //   },
        // ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: HexColor("#C0ABAF"),
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo);
            },
          ),
        ),
      ),
    );
  }
}