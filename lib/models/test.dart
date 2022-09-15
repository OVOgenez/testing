import 'package:testing/models/A.dart';

class Test {
  dynamic id;
  List<dynamic>? field;
  dynamic startX;
  dynamic startY;
  dynamic endX;
  dynamic endY;
  dynamic error;
  AStar? aStar;

  Test({
    this.id,
    this.field,
    this.startX,
    this.startY,
    this.endX,
    this.endY,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      field: json['field'],
      startX: json['start']['x'],
      startY: json['start']['y'],
      endX: json['end']['x'],
      endY: json['end']['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'result': {
        'steps': aStar!.answerList
            .map((e) => {
                  'x': e.x,
                  'y': e.y,
                })
            .toList(),
        'path': '${aStar!.answerList.length - 1}'
      },
    };
  }

  static List<List<int>> _getGridValues(gridList) {
    List<List<int>> map = [];
    var splited = gridList.map((r) => r.split(''));
    for (var list in splited) {
      map.add([]);
      for (var v in list) {
        if (v == 'X')
          map.last.add(0);
        else
          map.last.add(1);
      }
    }
    return map;
  }

  int calculatePath() {
    List<List<int>> map = _getGridValues(field);
    aStar = AStar(map, map.length, map.first.length);
    int flag = aStar!.searchCoords(startY, startX, endY, endX);
    aStar!.answerList.forEach((e) {
      var _temp = e.x;
      e.x = e.y;
      e.y = _temp;
    });
    return flag;
  }
}
