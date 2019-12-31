import 'dart:collection';

import 'package:colors/todo.dart';
import 'package:flutter/widgets.dart';

class TodosModel extends ChangeNotifier {
  List<Todo> _todos;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  TodosModel({@required todos}) : _todos = todos;

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  removeTodoAt(int id) {
    _todos.removeAt(id);

    notifyListeners();
  }

  toggleCompletedAt(int id) {
    _todos[id].toggleCompleted();

    notifyListeners();
  }

  clearAll() {
    _todos.clear();

    notifyListeners();
  }

  persist() {
    // TodoRepoFactory.getInstance().saveTodos();
  }
}
