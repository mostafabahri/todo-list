import 'dart:convert';

import 'package:todo_list/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoRepoFactory {
  static TodoRepository getInstance() => PrefsTodoRepo();
}

abstract class TodoRepository {
  fetchTodos();
  saveTodos(List<Todo> todos);
}

class PrefsTodoRepo implements TodoRepository {
  final kKey = 'flutter_todos';

  @override
  Future<List<Todo>> fetchTodos() async {
    var prefs = await SharedPreferences.getInstance();
    return TodosJsonDecoder().decode(prefs.getString(kKey));
  }

  @override
  saveTodos(List<Todo> todos) async {
    var prefs = await SharedPreferences.getInstance();

    var jsonString = jsonEncode(todos);

    print(await prefs.setString(kKey, jsonString));
  }
}

abstract class TodosDecoder {
  List<Todo> decode(String source);
}

class TodosJsonDecoder implements TodosDecoder {
  List<Todo> decode(String source) {
    var json = jsonDecode(source ?? '[]') as List;
    return json.map((item) => Todo.fromJson(item)).toList();
  }
}

class MemoryTodoRepo implements TodoRepository {
  @override
  Future<List<Todo>> fetchTodos() async {
    return Future.delayed(Duration(milliseconds: 2000),
        () => [Todo(text: 'buy milk'), Todo(text: 'type your todo')]);
  }

  @override
  saveTodos(List<Todo> todos) async {
    print('about to save...');
    var json = jsonEncode(todos);
    await Future.delayed(Duration(seconds: 1), () => print('saved : $json'));
  }
}
