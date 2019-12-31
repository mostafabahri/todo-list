import 'package:colors/choice.dart';
import 'package:colors/todo.dart';
import 'package:colors/todo_item.dart';
import 'package:colors/todos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatefulWidget {
  TodoForm();

  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final inputCtrl = TextEditingController();
  ScrollController _scrollController = ScrollController();

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
              Consumer<TodosModel>(
                builder: (context, model, _) => Expanded(
                    child: model.todos.length != 0
                        ? ListView.builder(
                            controller: _scrollController,
                            itemCount: model.todos.length,
                            itemBuilder: _todoItemBuilder,
                          )
                        : Center(
                            child: Text('Add something!'),
                          )),
              ),
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
                var todo = Todo(text: inputCtrl.text.trim());
                Provider.of<TodosModel>(context, listen: false).addTodo(todo);

                setState(() {
                  inputCtrl.text = '';
                });

                _scrollToBottom();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _todoItemBuilder(BuildContext context, int index) {
    final todo = Provider.of<TodosModel>(context, listen: false).todos[index];
    return TodoItem(
      todo: todo,
      index: index,
    );
  }

  void _handleSelect(Choice choice) {
    switch (choice.action) {
      case ChoiceAction.Delete:
        Provider.of<TodosModel>(context, listen: false).clearAll();
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
