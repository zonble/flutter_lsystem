import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/arrow_curve.dart';
import 'pages/cantor_set_page.dart';
import 'pages/hexagon_page.dart';
import 'pages/snowflake_page.dart';
import 'pages/tree_page.dart';
import 'pages/triangle_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter L-System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter L-System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _Item {
  String title;
  Widget widget;

  _Item(this.title, this.widget);
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    var _items = <_Item>[
      _Item('About Flutter L-System', AboutPage()),
      _Item('Circles', HexagonPage()),
      _Item('Tree', TreePage()),
      _Item('Cantor Set', CantorSetPage()),
      _Item('Sierpiński Triangle', TrianglePage()),
      _Item('Sierpiński Arrow Curve', ArrowCurvePage()),
      _Item('Snowflake', Snowflake()),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ClipRect(
        child: Center(
          child: _items[_index].widget,
        ),
      ),
      drawer: Drawer(
          child: ListView.builder(
        itemBuilder: (widget, index) {
          final item = _items[index];
          final isCurrent = index == _index;
          return ListTile(
              onTap: () {
                setState(() => _index = index);
                Navigator.of(context).pop();
              },
              trailing: isCurrent ? Icon(Icons.check) : null,
              title: Text(item.title,
                  style: TextStyle(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  )));
        },
        itemCount: _items.length,
      )),
    );
  }
}
