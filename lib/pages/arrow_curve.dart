import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class ArrowCurvePage extends StatefulWidget {
  const ArrowCurvePage({super.key});

  @override
  State<ArrowCurvePage> createState() => _ArrowCurvePageState();
}

class _ArrowCurvePageState extends State<ArrowCurvePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var _count = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: 0.5,
        upperBound: 1.0,
        duration: const Duration(seconds: 2));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commands = [
      SetMacro('a', [
        IfElse((_) => _['c'] == 1, [
          Forward((_) => 5)
        ], [
          RunMacro('b', (_) => {'c': _['c'] - 1}, preserveState: false),
          Right((_) => 60.0),
          RunMacro('a', (_) => {'c': _['c'] - 1}, preserveState: false),
          Right((_) => 60.0),
          RunMacro('b', (_) => {'c': _['c'] - 1}, preserveState: false),
        ])
      ]),
      SetMacro('b', [
        IfElse((_) => _['c'] == 1, [
          Forward((_) => 5)
        ], [
          RunMacro('a', (_) => {'c': _['c'] - 1}, preserveState: false),
          Left((_) => 60.0),
          RunMacro('b', (_) => {'c': _['c'] - 1}, preserveState: false),
          Left((_) => 60.0),
          RunMacro('a', (_) => {'c': _['c'] - 1}, preserveState: false),
        ])
      ]),
      Back((_) => pow(2, _count - 2) * 5.0),
      Left((_) => 90.0),
      Forward(
          (_) => (_controller.value ?? 0) * 10 * (_count % 2 != 0 ? 1 : -1)),
      Right((_) => 90.0),
      PenDown(),
      RunMacro('a', (_) => {'c': _count}),
      PenUp(),
      Right((_) => 90.0),
      Forward(
          (_) => (_controller.value ?? 0) * 10 * (_count % 2 != 0 ? 1 : -1)),
      Left((_) => 90.0),
      PenDown(),
      RunMacro('b', (_) => {'c': _count}),
    ];

    return Column(children: <Widget>[
      AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) => TurtleView(
              commands: commands,
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
              ))),
      SizedBox(
          width: 300,
          child: Slider(
            min: 3,
            max: 8,
            value: _count.toDouble(),
            onChanged: (value) => setState(() => _count = value.toInt()),
          ))
    ]);
  }
}
