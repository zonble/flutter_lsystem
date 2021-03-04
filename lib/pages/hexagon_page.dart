import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class HexagonPage extends StatefulWidget {
  HexagonPage({Key? key}) : super(key: key);

  @override
  _HexagonPageState createState() => _HexagonPageState();
}

class _HexagonPageState extends State<HexagonPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  var _width = 10.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 600));
    _controller?.repeat(period: Duration(seconds: 600));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var commands = <TurtleCommand>[
      SetMacro('tri', [
        IfElse((_) => _['l'] < 30, [
          Forward((_) => _['l'] / 2.0),
          Left((_) => 120.0),
          PenDown(),
          Repeat((_) => 6, [
            Forward((_) => _['l'] / 2.0),
            Left((_) => 60.0),
          ]),
        ], [
          RunMacro('tri', (_) => {'l': _['l'] / 2.0}),
          Repeat((_) => 6, [
            Left((_) => 60),
            PenUp(),
            Forward((_) => _['l'] * 0.6),
            RunMacro('tri', (_) => {'l': _['l'] / 2.0}),
            PenUp(),
            Back((_) => _['l'] * 0.6),
          ]),
        ]),
      ]),
      RunMacro('tri', (_) => {'l': _width}),
    ];

    return Column(
      children: <Widget>[
        AnimatedBuilder(
            animation: _controller!,
            builder: (context, snapshot) {
              return Transform.rotate(
                angle: 360 * (_controller?.value ?? 0),
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
    );
  }
}
