import 'package:todo_list/todos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ChoiceAction { Delete }

class Choice {
  const Choice({this.title, this.action});

  final String title;
  final ChoiceAction action;
}

class MorePopUp extends StatelessWidget {
  final List<Choice> choices = const <Choice>[
    Choice(title: 'Delete All', action: ChoiceAction.Delete),
  ];

  void _handleSelect(Choice choice, BuildContext context) {
    switch (choice.action) {
      case ChoiceAction.Delete:
        Provider.of<TodosModel>(context, listen: false).clearAll();
    }
  }

  const MorePopUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choice>(
      child: Icon(Icons.more_horiz),
      onSelected: (Choice choice) => _handleSelect(choice, context),
      itemBuilder: (BuildContext context) {
        return choices.map((Choice choice) {
          return PopupMenuItem<Choice>(
            value: choice,
            child: Text(choice.title),
          );
        }).toList();
      },
    );
  }
}
