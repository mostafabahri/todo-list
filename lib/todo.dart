import 'package:flutter/material.dart';

class Todo {
  final String text;
  bool completed;
  DateTime time;

  Todo({@required this.text, this.completed = false}) : time = DateTime.now();

  void toggleCompleted() {
    completed = !completed;
  }
}
