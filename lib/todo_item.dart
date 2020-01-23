import 'package:todo_list/todo.dart';
import 'package:todo_list/todos_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final int index;

  TodoItem({this.todo, this.index});

  @override
  Widget build(BuildContext context) {
    final notCompletedIconColor = Color(0xff4ed9d6);

    final completedIconColor = notCompletedIconColor.withAlpha(100);

    Widget getDissmissBackground(bool left) {
      return Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.red[400]),
        alignment: Alignment(left ? -0.9 : 0.9, 0),
        child: Icon(
          FontAwesomeIcons.trash,
          color: Colors.white,
          size: 20,
        ),
      );
    }

    return Dismissible(
      key: ValueKey<String>(todo.text),
      background: getDissmissBackground(true),
      secondaryBackground: getDissmissBackground(false),
      onDismissed: (DismissDirection direction) =>
          Provider.of<TodosModel>(context, listen: false).removeTodoAt(index),
      child: Card(
        elevation: 0,
        color: Color(0xfffff5fb),
        child: ListTile(
          title: Text(
            todo.text,
            style: TextStyle(
                decoration: todo.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: todo.completed ? Colors.grey : Colors.black),
          ),
          subtitle: Text('${todo.time.hour}:${todo.time.minute}'),
          leading: IconButton(
            icon: todo.completed
                ? Icon(
                    FontAwesomeIcons.checkCircle,
                    color: completedIconColor,
                  )
                : Icon(
                    FontAwesomeIcons.circle,
                    color: notCompletedIconColor,
                  ),
            onPressed: () => Provider.of<TodosModel>(context, listen: false)
                .toggleCompletedAt(index),
          ),
        ),
      ),
    );
  }
}
