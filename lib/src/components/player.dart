import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_game/src/components/exit.dart';
import 'package:maze_game/src/components/wall.dart';
import 'package:maze_game/src/mazeGame.dart';

class Player extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Player(
      {required Vector2 position,
      required MoveType moveType,
      required double size,
      required bool finish})
      : super(position: position) {
    this.moveType = moveType;
    _size = size;
    _finish = finish;
  }

  late ShapeHitbox hitbox;
  late Function moToWall;
  late MoveType moveType;
  late double _size;
  late bool _finish;

  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite("player.png");
    size = Vector2.all(_size);
    anchor = Anchor.center;

    final Paint defaultPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);

    super.onLoad();
  }

  void endMovePlayer() {
    position = position;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {}

    if (other is Wall) {
      if (moveType == MoveType.Right) {
        moveType = MoveType.None;
        position.x = other.x - 15;
      }
      if (moveType == MoveType.Left) {
        moveType = MoveType.None;
        position.x = other.x + 15;
      }
      if (moveType == MoveType.Up) {
        moveType = MoveType.None;
        position.y = other.y + 15;
      }
      if (moveType == MoveType.Down) {
        moveType = MoveType.None;
        position.y = other.y - 15;
      }
    }

    if (other is Exit) {}
  }
}
