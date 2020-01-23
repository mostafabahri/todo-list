import 'package:todo_list/todo.dart';
import 'package:todo_list/todo_repository.dart';
import 'package:test/test.dart';

void main() {
  test('Parses json to correct value and type', () {
    var jsonString = '''
    [{"text": "first", "completed": true, "time": "2018-05-30"},
    {"text": "second todo", "completed": false, "time": "2019-12-30 00:41:13"}]''';
    var todos = TodosJsonDecoder().decode(jsonString);

    var expected = [
      Todo(
        text: 'first',
        completed: true,
        time: DateTime.parse('2018-05-30'),
      ),
      Todo(
        text: 'second todo',
        completed: false,
        time: DateTime.parse('2019-12-30 00:41:13'),
      )
    ];
    expect(todos, equals(expected));
    expect(todos, TypeMatcher<List<Todo>>());
  });

  test('Parses initial null value correctly', () {
    var jsonString;

    var todos = TodosJsonDecoder().decode(jsonString);
    expect(todos, TypeMatcher<List<Todo>>());
    expect(todos, equals(List<Todo>()));
  });
}
