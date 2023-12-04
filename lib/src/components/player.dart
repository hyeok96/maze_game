import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_game/src/components/exit.dart';
import 'package:maze_game/src/components/wall.dart';
import 'package:maze_game/src/mazeGame.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  Player({
    required Vector2 position,
    required MoveType moveType,
    required double size,
    required bool finish,
    required double prevX,
    required double prevY,
  }) : super(position: position) {
    this.moveType = moveType;
    _size = size;
    _finish = finish;
    // _prevX = prevX;
    // _prevY = prevY;
  }

  late ShapeHitbox hitbox;
  late Function moToWall;
  late MoveType moveType;
  late double _size;
  late bool _finish;

  late double prevX;
  late double prevY;
  Set<MoveType> set = {};

  @override
  FutureOr<void> onLoad() async {
    // sprite = await gameRef.loadSprite("player.png");
    animation = await gameRef.loadSpriteAnimation(
        "player.png",
        SpriteAnimationData.sequenced(
            amount: 12, stepTime: 0.1, textureSize: Vector2.all(32)));
    anchor = Anchor.center;

    final Paint defaultPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    hitbox = CircleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);

    super.onLoad();
  }

  Future<void> _loadAnimated() async {}

  void endMovePlayer() {
    position = position;
  }

  @override
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {}

    if (other is Wall) {}

    if (other is Exit) {}
  }
}
