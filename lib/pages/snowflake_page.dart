import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class Snowflake extends StatefulWidget {
  @override
  _SnowflakeState createState() => _SnowflakeState();
}

class _SnowflakeState extends State<Snowflake>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var _width = 20.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
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
      SetMacro('snowflake', [
        IfElse((_) => _['long_side'] <= 10, [
          PenDown(),
          Forward((_) => _['long_side']),
          PenUp(),
        ], [
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
          Left((_) => 60),
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
          Right((_) => 120),
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
          Left((_) => 60),
          RunMacro('snowflake', (_) => {'long_side': _['long_side'] / 3}),
          Forward((_) => _['long_side'] / 3),
        ])
      ]),
      SetColor((_) => Colors.blue),
      PenUp(),
      Forward((_) => _width / 3),
      Left((_) => 90),
      Forward((_) => _width / 7 * 2),
      Right((_) => 90),
      PenDown(),
      Repeat((_) => 3, [
        Right((_) => 120),
        RunMacro('snowflake', (_) => {'long_side': _width}),
        Forward((_) => _width),
      ]),
    ];

    return Column(
      children: <Widget>[
        AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return Transform.scale(
                scale: 1.0 + _controller.value * 0.2,
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
            min: 20.0,
            max: 500.0,
            value: _width,
            onChanged: (value) => setState(() => _width = value),
          ),
        ),
      ],
    );
  }
}
