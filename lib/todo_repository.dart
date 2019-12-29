import 'dart:convert';

import 'package:colors/todo.dart';

abstract class TodoRepository {
  fetchTodos();
  saveTodos(List<Todo> todos);
}

class PrefsTodoRepo implements TodoRepository {
  @override
  fetchTodos() {}

  saveTodos(List<Todo> todos) {
    var jsonList = jsonEncode(todos);
  }
}

class MemoryTodoRepo implements TodoRepository {
  @override
  Future<List<Todo>> fetchTodos() async {
    return Future.delayed(Duration(milliseconds: 2000),
        () => [Todo(text: 'buy milk'), Todo(text: 'type your todo')]);
  }

  @override
  saveTodos(List<Todo> todos) {
    print('about to save...');
    var json = jsonEncode(todos);
    Future.delayed(Duration(seconds: 1), () => 'saved $json').then(
      (value) {
        print(value);
      },
    );
  }
}

class TodoRepoFactory {
  static TodoRepository getInstance() => MemoryTodoRepo();
}
