import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:maze_game/src/components/empty.dart';
import 'package:maze_game/src/components/exit.dart';
import 'package:maze_game/src/components/point.dart';
import 'package:maze_game/src/components/road.dart';
import 'package:maze_game/src/components/wall.dart';
import 'package:maze_game/src/components/wallType.dart';

import '../controller/maze_game_controller.dart';

enum DirectType { Wall, Empty, Exit }

class Background extends SpriteComponent with HasGameRef {
  late final MazeGameController _controller = Get.find<MazeGameController>();
  late int level;
  Background({
    required this.level,
  });

  final List<List<DirectType>> _tile = [];
  final List<List<Road>> _list = [];

  double componentSize = 50;

  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite("bg.png");
    size = Vector2(100, 100);
    position = Vector2(0, 0);

    await initMazeGame(size: level);
    super.onLoad();
  }

  Future<void> initMazeGame({required int size}) async {
    await initTile(size: size);

    //  미로의 경롤를 만드는 함수
    await makeMazeRoad(null, _list[0][0], _list, size);
    await exitMaze(size);
    await wallTypeChecking();
    await showImage(size: size);
  }

  Future<void> initTile({required int size}) async {
    // 미로 길 만들기 위한 이중 배열
    for (int y = 0; y < size; y++) {
      _list.add([]);
      for (int x = 0; x < size; x++) {
        _list[y].add(
          Road(
            y: y,
            x: x,
            visit: false,
            prev: null,
            direction: [
              MazePoint(y: y, x: x + 1),
              MazePoint(y: y + 1, x: x),
              MazePoint(y: y - 1, x: x),
              MazePoint(y: y, x: x - 1)
            ],
          ),
        );
      }

      // 미로의 벽을 만들기 위한 이중 배열
      // 일단 모든 위치를 벽으로 만든다.
    }
    for (int y = 0; y < size * 2 + 1; y++) {
      _tile.add([]);
      for (int x = 0; x < size * 2 + 1; x++) {
        _tile[y].add(DirectType.Wall);
      }
    }
  }

  // 미로의 길을 만드는 함수
  Future<void> makeMazeRoad(
      Road? prev, Road road, List<List> maze, int size) async {
    // 처음 시작 길을 설정
    road.prev = prev;

    // 처음 길의 벽을 길로 만들어 주는 로직
    if (road.prev == null) {
      _tile[0][1] = DirectType.Empty;
    } else {
      // 벽을 뚫는 로직
      int y = prev!.y - road.y;
      int x = prev.x - road.x;
      _tile[((road.y + 1) * 2 - 1 + y).toInt()]
          [((road.x + 1) * 2 - 1 + x).toInt()] = DirectType.Empty;
    }

    road.visit = true;
    // 방을 뚫는 로직
    _tile[((road.y + 1) * 2 - 1).toInt()][((road.x + 1) * 2 - 1).toInt()] =
        DirectType.Empty;

    road.direction.shuffle();

    while (true) {
      // road의 네 방면을 다 확인하고 없으면 반복문 종료
      if (road.direction.isEmpty) break;

      MazePoint lastPoint = road.direction.removeLast();
      int ny = lastPoint.y.toInt();
      int nx = lastPoint.x.toInt();
      if (ny >= 0 && ny < size && nx >= 0 && nx < size) {
        if (maze[ny][nx].visit == false) {
          makeMazeRoad(road, maze[ny][nx], maze, size);
        }
      }
    }
  }

  Future<void> exitMaze(int size) async {
    Random random = Random();
    while (true) {
      int r = random.nextInt(size * 2);

      if (_tile[r][_tile.length - 2] == DirectType.Empty) {
        _tile[r][_tile.length - 1] = DirectType.Exit;
        break;
      }
    }
  }

  Future<void> showImage({required int size}) async {
    for (int y = 0; y < _tile.length; y++) {
      for (int x = 0; x < _tile.length; x++) {
        if (_tile[y][x] == DirectType.Wall) {
          Wall wall = Wall(
            position: Vector2(componentSize * x + componentSize / 2,
                componentSize * y + componentSize / 2),
            type: map[y][x].wallTpyeNumber,
            size: componentSize,
          );
          await add(wall);
        } else if (_tile[y][x] == DirectType.Empty) {
          Empty empty = Empty(
              position: Vector2(componentSize * x + componentSize / 2,
                  componentSize * y + componentSize / 2),
              size: componentSize);
          await add(empty);
        } else {
          Exit exit = Exit(
              position: Vector2(componentSize * x + componentSize / 2,
                  componentSize * y + componentSize / 2),
              size: componentSize,
              controller: _controller,
              level: level);
          await add(exit);
        }
      }
    }
  }

  List<List<WallType>> map = [];

  Future<void> wallTypeChecking() async {
    for (int y = 0; y < _tile.length; y++) {
      map.add([]);
      for (int x = 0; x < _tile.length; x++) {
        List<MazePoint> mazePonitList = [
          MazePoint(y: y - 1, x: x),
          MazePoint(y: y, x: x + 1),
          MazePoint(y: y + 1, x: x),
          MazePoint(y: y, x: x - 1)
        ];

        bool up = false;
        bool right = false;
        bool down = false;
        bool left = false;

        if (_tile[y][x] == DirectType.Wall) {
          if (y + mazePonitList[0].y >= 0 &&
              y + mazePonitList[0].y < _tile.length &&
              x + mazePonitList[0].x >= 0 &&
              x + mazePonitList[0].x < _tile.length) {
            if (_tile[y + mazePonitList[0].y][x + mazePonitList[0].x] ==
                DirectType.Wall) {
              up = true;
            }
          }

          if (y + mazePonitList[1].y >= 0 &&
              y + mazePonitList[1].y < _tile.length &&
              x + mazePonitList[1].x >= 0 &&
              x + mazePonitList[1].x < _tile.length) {
            if (_tile[y + mazePonitList[1].y][x + mazePonitList[1].x] ==
                DirectType.Wall) {
              right = true;
            }
          }

          if (y + mazePonitList[2].y >= 0 &&
              y + mazePonitList[2].y < _tile.length &&
              x + mazePonitList[2].x >= 0 &&
              x + mazePonitList[2].x < _tile.length) {
            if (_tile[y + mazePonitList[2].y][x + mazePonitList[2].x] ==
                DirectType.Wall) {
              down = true;
            }
          }

          if (y + mazePonitList[3].y >= 0 &&
              y + mazePonitList[3].y < _tile.length &&
              x + mazePonitList[3].x >= 0 &&
              x + mazePonitList[3].x < _tile.length) {
            if (_tile[y + mazePonitList[3].y][x + mazePonitList[3].x] ==
                DirectType.Wall) {
              left = true;
            }
          }

          map[y].add(WallType(up: up, right: right, down: down, left: left));
        } else {
          map[y].add(WallType(up: up, right: right, down: down, left: left));
        }
      }
    }
  }
}
