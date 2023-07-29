import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/actors/instrument.dart';
import 'package:gamejam_baq_2023/actors/lya.dart';
import 'package:gamejam_baq_2023/menus/gameOver.dart';
import 'package:gamejam_baq_2023/menus/start.dart';
import 'package:gamejam_baq_2023/world/obstacle.dart';
import 'package:gamejam_baq_2023/world/goal.dart';
import 'package:gamejam_baq_2023/world/ground.dart';
import 'package:gamejam_baq_2023/world/stage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(GameWidget.controlled(
    gameFactory: GameJam2023.new,
    overlayBuilderMap: {
      'StartMenu': (_, GameJam2023 game) => StartMenu(game: game),
      'GameOver': (_, GameJam2023 game) => GameOver(game: game),
    },
    initialActiveOverlays: const ['StartMenu'],
  ));
}

class GameJam2023 extends FlameGame with HasCollisionDetection {
  Lya lya = Lya();
  double gravity = 100;
  double pushSpeed = 18;
  Vector2 velocity = Vector2(0, 0);

  double? mapWidth;
  double? mapHeight;

  late SpriteAnimation standAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation slideAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation deadAnimation;
  late SpriteAnimation victoryAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    TiledComponent homeMap =
        await TiledComponent.load('level_01.tmx', Vector2.all(32));
    add(homeMap);

    mapWidth = 32.0 * homeMap.tileMap.map.width;
    mapHeight = 32.0 * homeMap.tileMap.map.height;
    final ground = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (final obj in ground!.objects) {
      add(Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    final obstacles = homeMap.tileMap.getLayer<ObjectGroup>('obstacles');
    for (final obstacle in obstacles!.objects) {
      add(Obstacle(
          size: Vector2(obstacle.width, obstacle.height),
          position: Vector2(obstacle.x, obstacle.y)));
    }

    final collectables = homeMap.tileMap.getLayer<ObjectGroup>('collectables');
    for (final collectable in collectables!.objects) {
      final instrument = Instrument(tiledObject: collectable)
        ..sprite = await loadSprite('instruments/${collectable.type}.png')
        ..position = Vector2(collectable.x, collectable.y)
        ..size = Vector2(collectable.width, collectable.height);
      add(instrument);
    }

    final stages = homeMap.tileMap.getLayer<ObjectGroup>('stages');
    for (final stage in stages!.objects) {
      add(Stage(
          size: Vector2(stage.width, stage.height),
          position: Vector2(stage.x, stage.y)));
    }

    final goal = homeMap.tileMap.getLayer<ObjectGroup>('goal')!.objects.first;
    add(Goal(
        size: Vector2(goal.width, goal.height),
        position: Vector2(goal.x, goal.y)));

    camera.viewport = FixedResolutionViewport(Vector2(2368, mapHeight!));
    camera.followComponent(lya,
        worldBounds: Rect.fromLTWH(0, 0, mapWidth!, mapHeight!),
        relativeOffset: const Anchor(0.05, 0.5));

    standAnimation = SpriteAnimation.spriteList(
        [await loadSprite('lya_stand.png')],
        stepTime: 0.2);
    runAnimation = SpriteAnimation.spriteList(
        await fromJSONAtlas('lya_run.png', 'lya_run.json'),
        stepTime: 0.2);
    slideAnimation = SpriteAnimation.spriteList(
        [await loadSprite('lya_slide.png')],
        stepTime: 0.2);
    jumpAnimation = SpriteAnimation.spriteList(
        [await loadSprite('lya_jump.png')],
        stepTime: 0.2);
    hitAnimation = SpriteAnimation.spriteList([await loadSprite('lya_hit.png')],
        stepTime: 0.2);

    double startGroundHeight = ground.objects.first.height;
    Vector2 lyaSize = Vector2(320, 480);
    lya
      ..animation = runAnimation
      ..size = lyaSize
      ..position = Vector2(100, mapHeight! - lyaSize.y - startGroundHeight);
    add(lya);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!lya.onGround) {
      velocity.y += gravity;
      lya.position += velocity * dt;
    }

    if (lya.onDead) {
      overlays.add('GameOver');
    }

    lya.position.x += pushSpeed;
  }
}
