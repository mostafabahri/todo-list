import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
          elevation: 2,
        ),
        body: TodoForm(),
      ),
    );
  }
}

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class Todo {
  final String text;
  bool completed;
  DateTime time;

  Todo({@required this.text, this.completed = false}) : time = DateTime.now();

  void toggleCompleted() {
    completed = !completed;
  }
}

class _TodoFormState extends State<TodoForm> {
  final inputCtrl = TextEditingController();

  List<Todo> todos = [Todo(text: 'buy milk'), Todo(text: 'go run man')];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: <Widget>[
          _buildInputRow(),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: _todoItemBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildInputRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: inputCtrl,
            decoration: InputDecoration(
              hintText: 'e.g buy some coffee',
              border: InputBorder.none,
            ),
          ),
        ),
        RaisedButton(
          child: Text('Add'),
          onPressed: () {
            if (inputCtrl.text.isNotEmpty)
              setState(() {
                todos.add(Todo(text: inputCtrl.text));
                inputCtrl.text = '';
              });
          },
        )
      ],
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
      },
      removePressed: () {
        setState(() {
          todos.removeAt(index);
        });
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback togglePressed;
  final VoidCallback removePressed;

  TodoItem({this.todo, this.togglePressed, this.removePressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
            ? Icon(Icons.check_box)
            : Icon(Icons.check_box_outline_blank),
        onPressed: togglePressed,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: removePressed,
      ),
    );
  }
}
