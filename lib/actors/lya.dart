import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gamejam_baq_2023/main.dart';
import 'package:gamejam_baq_2023/world/goal.dart';
import 'package:gamejam_baq_2023/world/obstacle.dart';

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
      gameRef.velocity.y = 0;
      onGround = true;
    } else if (other is Obstacle) {
      gameRef.pushSpeed = 0;
      gameRef.lya.animation = gameRef.hitAnimation;
      // gameRef.lya.position.x = gameRef.camera.position.x + (gameRef.canvasSize.x / 2) - (gameRef.lya.width / 2);
      // gameRef.camera.follow = null;
      onDead = true;
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
}
