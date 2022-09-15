class Node {
  int x;
  int y;
  Node? parentNode;
  int g = 0;
  int h = 0;
  int f = 0;

  Node(this.x, this.y, this.parentNode);
}

class AStar {
  List<List<int>> map;
  List<Node> openList = [];
  List<Node> closeList = [];
  List<Node> answerList = [];
  final COST_STRAIGHT = 10;
  final COST_DIAGONAL = 14;
  int row;
  int column;

  AStar(this.map, this.row, this.column);

  dynamic searchCoords(int x1, int y1, int x2, int y2) {
    if (x1 < 0 ||
        x1 >= row ||
        x2 < 0 ||
        x2 >= row ||
        y1 < 0 ||
        y1 >= column ||
        y2 < 0 ||
        y2 >= column) {
      return -1;
    }
    if (map[x1][y1] == 0 || map[x2][y2] == 0) {
      return -1;
    }
    Node sNode = Node(x1, y1, null);
    Node eNode = Node(x2, y2, null);
    openList.add(sNode);
    List<Node> resultList = searchNodes(sNode, eNode);
    if (resultList.isEmpty) {
      return 0;
    }
    for (Node node in resultList) {
      map[node.x][node.y] = -1;
    }
    answerList = resultList;
    return 1;
  }

  List<Node> searchNodes(Node sNode, Node eNode) {
    List<Node> resultList = [];
    bool isFind = false;
    Node? node;
    while (openList.isNotEmpty) {
      node = openList.first;
      if (node.x == eNode.x && node.y == eNode.y) {
        isFind = true;
        break;
      }
      if ((node.y - 1) >= 0) {
        checkPath(node.x, node.y - 1, node, eNode, COST_STRAIGHT);
      }
      if ((node.y + 1) < column) {
        checkPath(node.x, node.y + 1, node, eNode, COST_STRAIGHT);
      }
      if ((node.x - 1) >= 0) {
        checkPath(node.x - 1, node.y, node, eNode, COST_STRAIGHT);
      }
      if ((node.x + 1) < row) {
        checkPath(node.x + 1, node.y, node, eNode, COST_STRAIGHT);
      }
      if ((node.x - 1) >= 0 && (node.y - 1) >= 0) {
        checkPath(node.x - 1, node.y - 1, node, eNode, COST_DIAGONAL);
      }
      if ((node.x - 1) >= 0 && (node.y + 1) < column) {
        checkPath(node.x - 1, node.y + 1, node, eNode, COST_DIAGONAL);
      }
      if ((node.x + 1) < row && (node.y - 1) >= 0) {
        checkPath(node.x + 1, node.y - 1, node, eNode, COST_DIAGONAL);
      }
      if ((node.x + 1) < row && (node.y + 1) < column) {
        checkPath(node.x + 1, node.y + 1, node, eNode, COST_DIAGONAL);
      }
      closeList.add(openList.removeAt(0));
      openList.sort((Node a, Node b) => b.f.compareTo(a.f));
    }
    if (isFind && node != null) {
      getPath(resultList, node);
    }
    return resultList;
  }

  bool checkPath(int x, int y, Node parentNode, Node eNode, int cost) {
    Node node = Node(x, y, parentNode);
    if (map[x][y] == 0) {
      closeList.add(node);
      return false;
    }
    if (isListContains(closeList, x, y) != -1) {
      return false;
    }
    var index = -1;
    if ((index = isListContains(openList, x, y)) != -1) {
      if ((parentNode.g + cost) < openList[index].g) {
        node.parentNode = parentNode;
        countG(node, eNode, cost);
        countF(node);
        openList[index] = node;
      }
    } else {
      node.parentNode = parentNode;
      count(node, eNode, cost);
      openList.add(node);
    }
    return true;
  }

  int isListContains(List<Node> list, int x, int y) {
    for (int i = 0; i < list.length; i++) {
      Node node = list[i];
      if (node.x == x && node.y == y) {
        return i;
      }
    }
    return -1;
  }

  void getPath(List<Node> resultList, Node node) {
    if (node.parentNode != null) {
      getPath(resultList, node.parentNode!);
    }
    resultList.add(node);
  }

  void count(Node node, Node eNode, int cost) {
    countG(node, eNode, cost);
    countH(node, eNode);
    countF(eNode);
  }

  void countG(Node node, Node eNode, int cost) {
    if (node.parentNode == null) {
      node.g = cost;
    } else {
      node.g = node.parentNode!.g + cost;
    }
  }

  void countH(Node node, Node eNode) {
    node.f = (node.x - eNode.x).abs() + (node.y - eNode.y).abs();
  }

  void countF(Node node) {
    node.f = node.g + node.f;
  }
}
