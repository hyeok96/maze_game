import 'dart:async';

import 'package:flame/components.dart';
import 'package:get/get.dart';

class MainBackground extends SpriteComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite("bg.png");
    size = Vector2(3000, 3000);
    position = Vector2(-500, -500);
    return super.onLoad();
  }
}
