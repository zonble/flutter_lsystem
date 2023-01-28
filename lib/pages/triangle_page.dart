import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class TrianglePage extends StatefulWidget {
  const TrianglePage({super.key});

  @override
  State<TrianglePage> createState() => _TrianglePageState();
}

class _TrianglePageState extends State<TrianglePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  var _width = 10.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 600));
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

    return Column(children: <Widget>[
      AnimatedBuilder(
          animation: _controller!,
          builder: (context, snapshot) {
            return Transform.rotate(
                angle: 360 * (_controller?.value ?? 0),
                child: TurtleView(
                    commands: commands,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 200,
                    )));
          }),
      SizedBox(
          width: 300,
          child: Slider(
            min: 10.0,
            max: 800.0,
            value: _width,
            onChanged: (value) => setState(() => _width = value),
          ))
    ]);
  }
}
