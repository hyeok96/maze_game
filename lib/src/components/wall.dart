import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_game/src/components/player.dart';
import 'package:maze_game/src/mazeGame.dart';

class Wall extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Wall({
    required Vector2 position,
    required int type,
    required double size,
    // required MoveType moveType,
  }) : super(position: position) {
    _type = type;
    _size = size;
    // this.moveType = moveType;
  }

  late ShapeHitbox hitbox;
  late int _type;
  late double _size;
  late Point rightPoint;
  late Point leftPoint;
  late Point upPoint;
  late Point downPoint;

  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite("wall.png");
    size = Vector2.all(_size);
    anchor = Anchor.center;

    final Paint defaultPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox(size: Vector2.all(_size))
      ..paint = defaultPaint
      ..renderShape = true;
    add(hitbox);

    print("positonx : ${position.x} positionY : ${position.y}");

    rightPoint = Point(position.x + _size / 2, position.y);
    leftPoint = Point(position.x - _size / 2, position.y);
    upPoint = Point(position.x, position.y - _size / 2);
    downPoint = Point(position.x, position.y + _size / 2);
    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      MoveType moveType = other.moveType;

      for (Vector2 point in intersectionPoints) {
        double pointX = point.x;
        double pointY = point.y;

        double positionX = position.x;
        double positionY = position.y;

        if (moveType == MoveType.Left) {
          // player가 왼쪽으로 이동
          if (pointX == rightPoint.x) {
            if ((point.y > rightPoint.y - _size / 2 &&
                point.y < rightPoint.y + _size / 2)) {
              other.position.x = positionX + size.x / 2 + other.size.x / 2;
            }
          }
        }

        if (moveType == MoveType.Right) {
          // player가 오르쪽으로 이동
          if (pointX == leftPoint.x) {
            if ((point.y > rightPoint.y - _size / 2 &&
                point.y < rightPoint.y + _size / 2)) {
              other.position.x = positionX - size.x / 2 - other.size.x / 2;
            }
          }
        }

        if (moveType == MoveType.Down) {
          // player가 아래으로 이동
          if (pointY == upPoint.y) {
            if ((point.x > upPoint.x - _size / 2 &&
                point.x < upPoint.x + _size / 2)) {
              other.position.y = positionY - size.y / 2 - other.size.y / 2;
            }
          }
        }

        if (moveType == MoveType.Up) {
          // player가 위으로 이동
          if (pointY == downPoint.y) {
            if ((point.x > upPoint.x - _size / 2 &&
                point.x < upPoint.x + _size / 2)) {
              other.position.y = positionY + size.y / 2 + other.size.y / 2;
            }
          }
        }
      }
    }
  }
}
