import 'package:flutter/material.dart';
import 'package:flutter_turtle/flutter_turtle.dart';

class CantorSetPage extends StatefulWidget {
  CantorSetPage({Key key}) : super(key: key);

  @override
  _CantorSetPageState createState() => _CantorSetPageState();
}

class _CantorSetPageState extends State<CantorSetPage> {
  var _width = 1;

  @override
  Widget build(BuildContext context) {
    var commands = <TurtleCommand>[
      SetMacro('a', [
        IfElse((_) => _['c'] == 1, [
          PenDown(),
          Forward((_) => _['l']),
        ], [
          RunMacro('a', (_) => {'c': _['c'] - 1, 'l': _['l'] / 3.0},
              preserveState: false),
          RunMacro('b', (_) => {'c': _['c'] - 1, 'l': _['l'] / 3.0},
              preserveState: false),
          RunMacro('a', (_) => {'c': _['c'] - 1, 'l': _['l'] / 3.0},
              preserveState: false),
        ])
      ]),
      SetMacro('b', [
        PenUp(),
        Forward((_) => _['l']),
      ]),
      SetMacro('line', [
        Right((_) => 90.0),
        Back((_) => _['l'] / 2.0),
        RunMacro('a', (_) => {'c': _['c'], 'l': _['l']}),
      ]),
      Forward((_) => 100.0),
      Repeat((_) => _width, [
        PenUp(),
        Back((_) => 20),
        SetStrokeWidth((_) => 6),
        RunMacro(
            'line',
            (_) =>
                {'c': _[repcount], 'l': MediaQuery.of(context).size.width - 40})
      ]),
    ];

    return Column(
      children: <Widget>[
        TurtleView(
          commands: commands,
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
          ),
        ),
        Container(
            width: 300,
            child: Slider(
              min: 1,
              max: 8,
              value: _width.toDouble(),
              onChanged: (value) => setState(() => _width = value.toInt()),
            )),
      ],
    );
  }
}
