import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff3863DC),
        fontFamily: 'Cera',
      ),
      home: Scaffold(
        body: SafeArea(child: TodoForm()),
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

  List<Todo> todos = [Todo(text: 'buy milk'), Todo(text: 'type your todo')];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(children: [
            Container(
              margin: EdgeInsets.only(top: 18, bottom: 18),
              padding: EdgeInsets.only(left: 3),
              child: Text(
                'To-do list',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ),
          ]),
          Expanded(
              child: todos.length != 0
                  ? ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: _todoItemBuilder,
                    )
                  : Center(
                      child: Text('Add something!'),
                    )),
          _buildInputRow(),
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
              hintText: 'I want to ...',
              border: InputBorder.none,
            ),
          ),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('+ Add Task'),
          onPressed: () {
            if (inputCtrl.text.isNotEmpty)
              setState(() {
                todos.add(Todo(text: inputCtrl.text));
                inputCtrl.text = '';
              });
          },
        ),
        SizedBox(
          width: 3,
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
    final completedIconColor = Theme.of(context).primaryColor.withAlpha(100);
    return Card(
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
        trailing: IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
