import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BoxPage(),
    );
  }
}

class BoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colors'),
      ),
      body: Box(),
    );
  }
}

class Box extends StatefulWidget {
  @override
  _BoxState createState() => _BoxState();
}

var rnd = Random();

Color getMeSomeColor() {
  var colors = Colors.primaries;
  return colors[rnd.nextInt(colors.length)];
}

class _BoxState extends State<Box> {
  var _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _color = getMeSomeColor();
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _color,
              boxShadow: [
                BoxShadow(
                    color: _color.withAlpha(80),
                    offset: Offset(0, 0),
                    blurRadius: 15,
                    spreadRadius: 8),
              ]),
          width: 300,
          height: 300,
          child: Center(
              child: Text(
            'tap me',
            style: TextStyle(fontSize: 40, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
