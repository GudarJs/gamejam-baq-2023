import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/actors/lya.dart';
import 'package:gamejam_baq_2023/world/ground.dart';

void main() {
  runApp(GameWidget(game: GameJam2023()));
}

class GameJam2023 extends FlameGame with HasCollisionDetection {

  Lya lya = Lya();
  double gravity = 9.8;
  Vector2 velocity = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    TiledComponent homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(homeMap);

    double mapWidth = 32.0 * homeMap.tileMap.map.width;
    double mapHeight = 32.0 * homeMap.tileMap.map.height;
    final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (final obj in obstacleGroup!.objects) {
      add(Ground(size: Vector2(obj.width, obj.height), position: Vector2(obj.x, obj.y)));
    }

    final boxes = homeMap.tileMap.getLayer<ObjectGroup>('boxes');

    for (final box in boxes!.objects) {
      add(Ground(size: Vector2(box.width, box.height), position: Vector2(box.x, box.y)));
    }

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    lya
      ..sprite = await loadSprite('lya.png')
      ..size = Vector2(192, 256)
      ..position = Vector2(100, 30);
    add(lya);

  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!lya.onGround) {
      velocity.y += gravity;
      lya.position.y += velocity.y * dt;
    }
  }

}
