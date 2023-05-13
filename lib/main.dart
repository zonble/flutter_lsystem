import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/about_page.dart';
import 'pages/arrow_curve.dart';
import 'pages/cantor_set_page.dart';
import 'pages/hexagon_page.dart';
import 'pages/snowflake_page.dart';
import 'pages/tree_page.dart';
import 'pages/triangle_page.dart';

void main() => runApp(const MyApp());

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (c, animation, a2, child) => FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final _curveTween = CurveTween(curve: Curves.easeIn);
}

final _items = <_Item>[
  _Item('About Flutter L-System', '/about', () => const AboutPage()),
  _Item('Tree', '/tree', () => const TreePage()),
  _Item('Cantor Set', '/cantor_set', () => const CantorSetPage()),
  _Item('Sierpiński Triangle', '/triangle', () => const TrianglePage()),
  _Item('Sierpiński Arrow Curve', '/arrow_curve', () => const ArrowCurvePage()),
  _Item('Snowflake', '/snowflake', () => const Snowflake()),
  _Item('Hexagons', '/hexagons', () => const HexagonPage()),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FadeTransitionPage h(GoRouterState state, Widget child) {
      return FadeTransitionPage(
          key: state.pageKey,
          child: MyHomePage(title: 'Flutter L-System', child: child));
    }

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => h(state, const TreePage()),
        ),
        ..._items.map((item) => GoRoute(
            path: item.path,
            pageBuilder: (context, state) {
              return h(state, item.widget());
            })),
      ],
    );

    return MaterialApp.router(
      title: 'Flutter L-System',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
      // routeInformationParser: router.routeInformationParser,
      // routerDelegate: router.routerDelegate,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Widget child;

  const MyHomePage({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _Item {
  String title;
  String path;
  Widget Function() widget;

  _Item(this.title, this.path, this.widget);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Drawer(
        child: ListView.builder(
      itemBuilder: (widget, index) {
        final item = _items[index];
        return ListTile(
            onTap: () {
              Navigator.of(context).pop();
              final path = item.path;
              print('path $path');
              context.go(path);
            },
            title: Text(item.title, style: const TextStyle()));
      },
      itemCount: _items.length,
    ));

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: ClipRect(
          child: Center(
            child: widget.child,
          ),
        ),
        drawer: drawer);
  }
}
