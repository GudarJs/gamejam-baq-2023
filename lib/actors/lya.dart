import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gamejam_baq_2023/main.dart';

import '../world/ground.dart';

class Lya extends SpriteComponent with CollisionCallbacks, HasGameRef<GameJam2023> {

  Lya() : super() {
    debugMode = true;
  }

  bool onGround = false;

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
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Ground) {
      onGround = false;
    }
  }
}
