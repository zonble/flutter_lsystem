import 'package:flutter/material.dart';

import 'pages/tree.dart';
import 'pages/triangle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter L-System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    var _items = <_Item>[
      _Item('Tree', TreePage()),
      _Item('Sierpinski Triangle', Triangle()),
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
          return ListTile(
              onTap: () {
                setState(() => _index = index);
                Navigator.of(context).pop();
              },
              title: Text(item.title));
        },
        itemCount: _items.length,
      )),
    );
  }
}
