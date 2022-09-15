import 'package:flutter/material.dart';
import 'package:testing/models/test.dart';
import 'package:testing/pages/preview_screen.dart';

class ResultListScreen extends StatelessWidget {
  final List<Test> tests;

  const ResultListScreen(this.tests, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result list Screen')),
      body: ListView.separated(
          itemCount: tests.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: Text(
                  tests[index].aStar!.answerList.map((e) => '(${e.x},${e.y})').join('>'),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewScreen(tests[index])),
                );
              },
            );
          }),
    );
  }
}
