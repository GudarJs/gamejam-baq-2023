import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gamejam_baq_2023/actors/instrument.dart';
import 'package:gamejam_baq_2023/main.dart';
import 'package:gamejam_baq_2023/world/goal.dart';
import 'package:gamejam_baq_2023/world/obstacle.dart';
import 'package:gamejam_baq_2023/world/stage.dart';

import '../world/ground.dart';

class Lya extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<GameJam2023> {

  Lya() : super() {
    debugMode = true;
  }

  bool onGround = false;
  bool onDead = false;
  bool onGoalReached = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      gameRef.jumpCount = 0;
      gameRef.velocity.y = 0;
      onGround = true;
    } else if (other is Obstacle) {
      gameRef.pushSpeed = 0;
      gameRef.lya.animation = gameRef.hitAnimation;
      _declareDead();
    } else if (other is Instrument) {
      final String instrument = other.tiledObject.type;
      game.instrumentsCollected[instrument] = true;
      gameRef.remove(other);
    } else if (other is Stage) {
      if ((y + height) >= other.height) {
        gameRef.pushSpeed = 0;
        gameRef.lya.animation = gameRef.hitAnimation;
        // Future.delayed(const Duration(milliseconds: 400), () {
        //   game.lya.animation = game.deadAnimation;
        // });
        _declareDead();
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Ground) {
      onGround = false;
    } else if (other is Goal) {
      gameRef.pushSpeed = 0;
      gameRef.lya.animation = gameRef.standAnimation;
      onGoalReached = true;
    }
  }

  void _declareDead() {
      gameRef.camera.speed = 3000;
      gameRef.camera.moveTo(Vector2(gameRef.lya.position.x - gameRef.lya.width - (gameRef.lya.width / 2) - (gameRef.canvasSize.x / 2), gameRef.camera.position.y));
      onDead = true;
  }
}
