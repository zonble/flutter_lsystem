import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class Triangle extends StatefulWidget {
  Triangle({Key key}) : super(key: key);

  @override
  _TriangleState createState() => _TriangleState();
}

class _TriangleState extends State<Triangle>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _width = 10.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 600));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commands = <TurtleCommand>[
      SetMacro('tri', [
        If((_) => _['l'] < 10, [Stop()]),
        PenDown(),
        RunMacro('tri', (_) => {'l': _['l'] / 2.0}),
        Forward((_) => _['l']),
        Left((_) => 120),
        RunMacro('tri', (_) => {'l': _['l'] / 2.0}),
        Forward((_) => _['l']),
        Left((_) => 120),
        RunMacro('tri', (_) => {'l': _['l'] / 2.0}),
        Forward((_) => _['l']),
      ]),
      PenUp(),
      SetStrokeWidth((_) => 1),
      Forward((_) => (_width / 2)),
      Left((_) => 90),
      Forward((_) => (_width / 3)),
      Left((_) => 90.0),
      RunMacro('tri', (_) => {'l': _width}),
    ];

    return Container(
      child: Column(
        children: <Widget>[
          AnimatedBuilder(

              animation: _controller,
              builder: (context, snapshot) {
                return Transform.rotate(
                  angle: 360 * _controller.value,
                  child: TurtleView(
                    commands: commands,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                    ),
                  ),
                );
              }),
          Container(
            width: 300,
            child: Slider(
              min: 10.0,
              max: 500.0,
              value: _width,
              onChanged: (value) => setState(() => _width = value),
            ),
          ),
        ],
      ),
    );
  }
}
