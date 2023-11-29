import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_game/src/components/player.dart';

class Wall extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Wall({required Vector2 position, required int type, required double size})
      : super(position: position) {
    _type = type;
    _size = size;
  }

  late ShapeHitbox hitbox;
  late int _type;
  late double _size;

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

    super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {}
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
  }
}
