import 'dart:math';

import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  @override
  _BoxState createState() => _BoxState();
}

var _rnd = Random();

Color getMeSomeColor() {
  var colors = Colors.primaries;
  return colors[_rnd.nextInt(colors.length)];
}

class _BoxState extends State<Box> {
  var _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GestureDetector(
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
          alignment: Alignment.center,
          child: Text(
            'tap me',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
      ),
    ]);
  }
}
