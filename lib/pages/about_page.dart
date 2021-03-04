import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 640),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('About',
                            style: Theme.of(context).textTheme.display1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'An L-system or Lindenmayer system is a parallel rewriting system and a type of formal grammar.\n\n'
                          'An L-system consists of an alphabet of symbols that can be used to make strings, a collection of production rules that expand each symbol into some larger string of symbols, an initial "axiom" string from which to begin construction, and a mechanism for translating the generated strings into geometric structures.\n\n'
                          'L-systems were introduced and developed in 1968 by Aristid Lindenmayer, a Hungarian theoretical biologist and botanist at the University of Utrecht. Lindenmayer used L-systems to describe the behaviour of plant cells and to model the growth processes of plant development.\n\n'
                          'L-systems have also been used to model the morphology of a variety of organisms and can be used to generate self-similar fractals.',
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child:
                                Text('- Wikipedia', textAlign: TextAlign.right),
                          ))
                    ]))));
  }
}
