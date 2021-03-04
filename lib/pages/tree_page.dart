import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class TreePage extends StatefulWidget {
  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage>
    with SingleTickerProviderStateMixin {
  double _value = 10.0;
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    controller?.repeat(reverse: true, period: Duration(seconds: 5));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commands = [
      SetMacro('a', [
        IfElse((_) => _['l'] < 10.0, [
          Stop()
        ], [
          IfElse((_) => _['l'] < 30.0, [
            SetColor((_) => Colors.green),
            SetStrokeWidth((_) => 8),
          ], [
            SetColor((_) => Colors.brown),
            SetStrokeWidth((_) => min(_['l'] / 5.0, 50.0)),
          ]),
          Back((_) => 4.0),
          Forward((_) => 4.0),
          Forward((_) => min(_['l'], 60.0)),
          Left((_) =>
              20.0 + ((controller?.value ?? 0) * 3) / max(1, _value / 100.0)),
          RunMacro('a', (_) => {'l': (_['l'] / 5.0 * 4.0)}),
          Right((_) =>
              40.0 + ((controller?.value ?? 0) * 3 / max(1, _value / 100.0))),
          RunMacro('b', (_) => {'l': (_['l'] / 5.0 * 4.0)}),
        ]),
      ]),
      SetMacro('b', [
        IfElse((_) => _['l'] < 10.0, [
          Stop()
        ], [
          IfElse((_) => _['l'] < 30.0, [
            SetColor((_) => Colors.green),
            SetStrokeWidth((_) => 8),
          ], [
            SetColor((_) => Colors.brown),
            SetStrokeWidth((_) => min(_['l'] / 5.0, 50.0)),
          ]),
          Back((_) => 4.0),
          Forward((_) => 4.0),
          Forward((_) => min(_['l'], 60.0)),
          Right((_) =>
              20.0 - ((controller?.value ?? 0) * 5) / max(1, _value / 100.0)),
          RunMacro('a', (_) => {'l': (_['l'] / 5.0 * 4.0)}),
        ]),
      ]),
      Back((_) => 200),
      PenDown(),
      RunMacro('a', (_) => {'l': _value}),
    ];

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          AnimatedBuilder(
              animation: controller!,
              builder: (context, snapshot) => TurtleView(
                  commands: commands,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                  ))),
          Container(
              width: 300,
              child: Slider(
                min: 10.0,
                max: 250.0,
                value: _value,
                onChanged: (value) => setState(() => _value = value),
              ))
        ]));
  }
}
