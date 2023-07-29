
import 'dart:developer';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:gamejam_baq_2023/actors/lya.dart';

class Instrument extends SpriteComponent with CollisionCallbacks{
  final TiledObject tiledObject;
  Instrument({required this.tiledObject}) :super(){
    debugMode = true;
  }

  @override
  Future<void> onCollision(Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Lya) {
    log("on instrument Collision");

      removeFromParent();
    }
    super.onCollision( intersectionPoints, other);

  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    return super.onLoad();
  }

}