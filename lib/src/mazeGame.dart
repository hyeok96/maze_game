import 'dart:async';
import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/src/components/core/component.dart';
import 'package:maze_game/src/components/background.dart';
import 'package:maze_game/src/components/wallType.dart';

import 'components/player.dart';

enum MoveType { None, Up, Down, Right, Left }

class MazeGame extends FlameGame with HasCollisionDetection {
  MazeGame(
      {required bool finish,
      required int level,
      required double right,
      required double bottom})
      : super() {
    _finish = finish;
    _level = level;
    _right = right;
    _bottom = bottom;
  }

  late Player _player;
  late bool _finish;
  late int _level;
  late double _right;
  late double _bottom;

  double componentSize = 50;

  double prevX = 75;
  double prevY = 25;

  @override
  final World world = World();

  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    final Background bg = Background(level: _level);
    await add(world);
    world.add(bg);

    bg.loaded.then((value) {
      _player = Player(
        finish: _finish,
        position: Vector2(75, 25),
        moveType: MoveType.None,
        size: 20,
        prevX: prevX,
        prevY: prevY,
      );

      cameraComponent = CameraComponent(world: world);
      cameraComponent.follow(_player);
      cameraComponent.setBounds(
        Rectangle.fromLTRB(0, 0, _right, _bottom),
      );
      cameraComponent.viewfinder.anchor = const Anchor(0.17, 0.025);

      add(cameraComponent);

      cameraComponent.world!.add(_player);
    });
  }

  void movePlayer({required String type}) {
    switch (type) {
      case "up":
        _player.position = Vector2(_player.position.x, _player.position.y - 1);
        _player.moveType = MoveType.Up;
        _player.angle = pi;

      case "down":
        _player.position = Vector2(_player.position.x, _player.position.y + 1);
        _player.moveType = MoveType.Down;
        _player.angle = 0;
      case "right":
        _player.position = Vector2(_player.position.x + 1, _player.position.y);
        _player.moveType = MoveType.Right;
        _player.angle = pi + pi / 2;
      case "left":
        _player.position = Vector2(_player.position.x - 1, _player.position.y);
        _player.moveType = MoveType.Left;
        _player.angle = pi / 2;
    }
  }
}
