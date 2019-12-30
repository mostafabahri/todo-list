import 'package:colors/choice.dart';
import 'package:colors/todo.dart';
import 'package:colors/todo_item.dart';
import 'package:colors/todo_repository.dart';
import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  final List<Todo> todos;

  TodoForm({@required this.todos});

  _TodoFormState createState() => _TodoFormState(todos: todos);
}

class _TodoFormState extends State<TodoForm> {
  final inputCtrl = TextEditingController();
  List<Todo> todos;
  final TodoRepository repository;

  ScrollController _scrollController = ScrollController();

  _TodoFormState({this.todos}) : repository = TodoRepoFactory.getInstance();

  persist() {
    repository.saveTodos(todos);
  }

  @override
  Widget build(BuildContext context) {
    final background = AssetImage('assets/images/pattern-hd.jpg');
    var imageDecoration = BoxDecoration(
      image: DecorationImage(image: background, fit: BoxFit.cover),
    );
    return Container(
        decoration: imageDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 18, bottom: 18, right: 5),
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To-do list',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      CustomPopUp(
                        handleOnSelect: _handleSelect,
                      ),
                    ]),
              ),
              Expanded(
                  child: todos.length != 0
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: todos.length,
                          itemBuilder: _todoItemBuilder,
                        )
                      : Center(
                          child: Text('Add something!'),
                        )),
              _buildInputRow(),
            ],
          ),
        ));
  }

  Widget _buildInputRow() {
    return Container(
      margin: EdgeInsets.only(top: 7),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: inputCtrl,
              decoration: InputDecoration(
                hintText: 'I want to ...',
                border: InputBorder.none,
              ),
            ),
          ),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color(0xff2c2f36),
            textColor: Colors.white,
            child: Text('+ Add Task'),
            onPressed: () {
              if (inputCtrl.text.isNotEmpty) {
                setState(() {
                  todos.add(Todo(text: inputCtrl.text.trim()));
                  inputCtrl.text = '';
                });

                persist();
                _scrollToBottom();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _todoItemBuilder(BuildContext context, int index) {
    final todo = todos[index];
    return TodoItem(
      todo: todo,
      togglePressed: () {
        setState(() {
          todo.toggleCompleted();
        });
        persist();
      },
      removePressed: () {
        setState(() {
          todos.removeAt(index);
        });
        persist();
      },
    );
  }

  void _handleSelect(Choice choice) {
    switch (choice.action) {
      case ChoiceAction.Delete:
        {
          setState(() {
            todos.clear();
          });
          persist();
        }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.positions.toList().isNotEmpty) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease);
    }
  }
}

class CustomPopUp extends StatelessWidget {
  final List<Choice> choices = const <Choice>[
    Choice(title: 'Delete all', action: ChoiceAction.Delete),
  ];

  final Function handleOnSelect;

  const CustomPopUp({Key key, @required this.handleOnSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choice>(
      child: Icon(Icons.more_horiz),
      onSelected: handleOnSelect,
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
