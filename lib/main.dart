import 'dart:developer';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/actors/instrument.dart';
import 'package:gamejam_baq_2023/actors/lya.dart';
import 'package:gamejam_baq_2023/hud/hud.dart';
import 'package:gamejam_baq_2023/world/ground.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: GameWidget(game: GameJam2023(), overlayBuilderMap: {
    'HudOverlay': (BuildContext context, GameJam2023 game){
      return Hud(game: game,);
    }
  },))));
}

class GameJam2023 extends FlameGame with HasCollisionDetection, TapDetector {

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
      // add(Ground(size: Vector2(box.width, box.height), position: Vector2(box.x, box.y)));
      add(Instrument(tiledObject: box)..sprite = await loadSprite("box.png")..position = Vector2(box.x, box.y)..size = Vector2(box.width, box.height));
    }

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    lya
      ..sprite = await loadSprite('lya.png')
      ..size = Vector2(192, 256)
      ..position = Vector2(100, 350);
    add(lya);

    overlays.add('HudOverlay');

  }

  @override
  void onTapDown(TapDownInfo info) {
    log("object");
    if (lya.onGround) {
      lya.onGround =  false;
      velocity.y -= 100;
      lya.position.y -= 100;
      
    }
    super.onTapDown(info);
  }
  

  

  @override
  void update(double dt) {
    super.update(dt);

    if (!lya.onGround) {
      velocity.y += gravity;
      lya.position += velocity * dt;
    }
  }

}
