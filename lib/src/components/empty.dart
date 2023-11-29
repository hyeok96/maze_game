import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Empty extends SpriteComponent with HasGameRef, CollisionCallbacks {
  Empty({required Vector2 position, required double size})
      : super(position: position) {
    _size = size;
  }

  late double _size;
  late ShapeHitbox hitbox;

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
}
