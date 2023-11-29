import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_game/src/components/player.dart';
import 'package:maze_game/src/controller/maze_game_controller.dart';
import 'package:maze_game/src/core/game_state.dart';

class Exit extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Exit(
      {required Vector2 position,
      required double size,
      required MazeGameController controller,
      required int level})
      : super(position: position) {
    _size = size;
    _controller = controller;
    _level = level;
  }

  late double _size;
  late ShapeHitbox hitbox;
  late MazeGameController _controller;
  late int _level;

  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite("road.png");
    size = Vector2.all(_size);
    anchor = Anchor.center;

    final Paint defaultPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      other.position.x = other.position.x - 15;
      _controller.endGame();

      // _controller.endGame(_level);
    }
  }
}
