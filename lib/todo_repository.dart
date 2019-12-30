import 'dart:convert';

import 'package:colors/todo.dart';

class TodoRepoFactory {
  static TodoRepository getInstance() => MemoryTodoRepo();
}

abstract class TodoRepository {
  fetchTodos();
  saveTodos(List<Todo> todos);
}

class PrefsTodoRepo implements TodoRepository {
  @override
  Future<List<Todo>> fetchTodos() {
    var source = '''
    [{"text": "save json", "completed": true, "time": "2019-12-30 00:42:13.273346"},
    {"text": "get it going", "completed": false, "time": "2019-12-30 00:42:13.273347"},
    {"text": "third todo", "completed": false, "time": "2019-12-30 00:41:13"}]''';

    var todos = TodosJsonDecoder().decode(source);
    return Future.delayed(Duration(milliseconds: 600), () => todos);
  }

  saveTodos(List<Todo> todos) {
    // var jsonList = jsonEncode(todos);
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
