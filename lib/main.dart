import 'package:colors/todo_form.dart';
import 'package:flutter/material.dart';

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
          popupMenuTheme: PopupMenuThemeData(elevation: 2)),
      home: Scaffold(
        body: SafeArea(child: TodoForm()),
      ),
    );
  }
}
