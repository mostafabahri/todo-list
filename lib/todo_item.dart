import 'package:colors/todo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback togglePressed;
  final VoidCallback removePressed;

  TodoItem({this.todo, this.togglePressed, this.removePressed});

  @override
  Widget build(BuildContext context) {
    final completedIconColor = Theme.of(context).primaryColor.withAlpha(100);
    return Dismissible(
      key: ValueKey<String>(todo.text),
      background: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: Colors.red[400]),
        alignment: Alignment(0.9, 0),
        child: Icon(
          FontAwesomeIcons.trash,
          color: Colors.white,
          size: 20,
        ),
      ),
      onDismissed: (DismissDirection direction) {
        removePressed();
      },
      child: Card(
        elevation: 0,
        child: ListTile(
          title: Text(
            todo.text,
            style: TextStyle(
                decoration: todo.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
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
                    color: completedIconColor,
                  ),
            onPressed: togglePressed,
          ),
          // trailing: IconButton(
          //   icon: Icon(
          //     Icons.more_horiz,
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   onPressed: () {},
          // ),
        ),
      ),
    );
  }
}
