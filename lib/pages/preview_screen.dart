import 'package:flutter/material.dart';
import 'package:testing/models/test.dart';

class PreviewScreen extends StatelessWidget {
  final Test test;

  const PreviewScreen(this.test, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _grid = test.aStar!.map;
    final _path = test.aStar!.answerList;

    return Scaffold(
      appBar: AppBar(title: const Text('Preview screen')),
      body: Column(
        children: [
          Flexible(
            child: Column(
              children: List.generate(
                _grid.length,
                (i) => Flexible(
                  child: Row(
                    children: List.generate(
                      _grid[i].length,
                      (j) {
                        var backgroundColor = Colors.white;
                        var textColor = Colors.black;
                        if (_grid[i][j] == 0) {
                          backgroundColor = Colors.black;
                          textColor = Colors.white;
                        }
                        var c = _path.where((e) => (e.x == j && e.y == i));
                        if (c.isNotEmpty) {
                          backgroundColor = Color(0xff4CAF50);
                          if (_path.indexOf(c.first) == 0) {
                            backgroundColor = Color(0xff64FFDA);
                          }
                          if (_path.indexOf(c.first) == _path.length - 1) {
                            backgroundColor = Color(0xff009688);
                          }
                        }
                        return Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                '($j,$i)',
                                style: TextStyle(color: textColor),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                _path.map((e) => '(${e.x},${e.y})').join('->'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
