import 'package:maze_game/src/components/point.dart';

class Road {
  int y;
  int x;
  bool visit;
  Road? prev;
  List<MazePoint> direction;

  Road(
      {required this.y,
      required this.x,
      required this.visit,
      required this.prev,
      required this.direction});
}
