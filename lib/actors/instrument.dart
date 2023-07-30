import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Instrument extends SpriteComponent with CollisionCallbacks {
  Instrument({
    required this.tiledObject,
  }) : super() {
    debugMode = false;
  }

  final TiledObject tiledObject;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }
}
