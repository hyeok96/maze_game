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

// enum DirectType { Wall, Empty, Exit }

class MazeGame extends FlameGame with HasCollisionDetection {
  MazeGame({required bool finish, required int level}) : super() {
    _finish = finish;
    _level = level;
  }

  // late final List<List<DirectType>> _tile = [];
  // late final List<List<Road>> _list = [];

  late Player _player;
  late bool _finish;
  late int _level;

  double componentSize = 50;

  @override
  final World world = World();

  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    final Background bg = Background(level: _level);

    await add(world);
    world.add(bg);

    print("aaa :${(componentSize * (_level))}");

    bg.loaded.then((value) {
      _player = Player(
          finish: _finish,
          position: Vector2(75, 20),
          moveType: MoveType.None,
          size: 40);

      cameraComponent = CameraComponent(world: world);
      cameraComponent.follow(_player);
      cameraComponent.setBounds(
        Rectangle.fromLTRB(0, 20, 600, (componentSize * (_level)) * 0.29),
      );
      cameraComponent.viewfinder.anchor = const Anchor(0.17, 0.025);

      add(cameraComponent);

      cameraComponent.world!.add(_player);
    });
  }

  void movePlayer({required String type}) {
    switch (type) {
      case "up":
        _player.position = Vector2(_player.position.x, _player.position.y - 15);
        _player.moveType = MoveType.Up;
      case "down":
        _player.position = Vector2(_player.position.x, _player.position.y + 15);
        _player.moveType = MoveType.Down;
      case "right":
        _player.position = Vector2(_player.position.x + 15, _player.position.y);
        _player.moveType = MoveType.Right;
      case "left":
        _player.position = Vector2(_player.position.x - 15, _player.position.y);
        _player.moveType = MoveType.Left;
    }
  }
}