import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_texturepacker/flame_texturepacker.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/actors/instrument.dart';
import 'package:gamejam_baq_2023/actors/lya.dart';
import 'package:gamejam_baq_2023/controls/mobile_controls.dart';
import 'package:gamejam_baq_2023/menus/gameOver.dart';
import 'package:gamejam_baq_2023/menus/pause.dart';
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
      'MobileControls': (_, GameJam2023 game) => MobileControls(game: game),
      'Pause': (_, GameJam2023 game) => Pause(game: game),
    },
    initialActiveOverlays: const ['MobileControls', 'StartMenu'],
  ));
}

class GameJam2023 extends FlameGame with HasCollisionDetection {
  Lya lya = Lya();
  double gravity = 100;
  double pushSpeed = 0;
  Vector2 velocity = Vector2(0, 0);

  late TiledComponent levelMap;
  late double mapWidth;
  late double mapHeight;

  late List<Ground> groundObjects;
  late List<Obstacle> obstacleObjects;
  late List<Instrument> instrumentObjects;

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

    levelMap = await TiledComponent.load('level_01.tmx', Vector2.all(32));
    add(levelMap);

    mapWidth = 32.0 * levelMap.tileMap.map.width;
    mapHeight = 32.0 * levelMap.tileMap.map.height;

    final ground = levelMap.tileMap.getLayer<ObjectGroup>('ground');
    groundObjects = ground!.objects.map((obj) {
      return Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y));
    }).toList();
    addAll(groundObjects);

    final obstacles = levelMap.tileMap.getLayer<ObjectGroup>('obstacles');
    obstacleObjects = obstacles!.objects.map((obj) {
      return Obstacle(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y));
    }).toList();
    addAll(obstacleObjects);

    final collectables = levelMap.tileMap.getLayer<ObjectGroup>('collectables');
    instrumentObjects =
        await Future.wait(collectables!.objects.map((obj) async {
      return Instrument(tiledObject: obj)
        ..sprite = await loadSprite('instruments/${obj.type}.png')
        ..position = Vector2(obj.x, obj.y)
        ..size = Vector2(obj.width, obj.height);
    }).toList());
    addAll(instrumentObjects);

    final stages = levelMap.tileMap.getLayer<ObjectGroup>('stages');
    for (final stage in stages!.objects) {
      add(Stage(
          size: Vector2(stage.width, stage.height),
          position: Vector2(stage.x, stage.y)));
    }

    final goal = levelMap.tileMap.getLayer<ObjectGroup>('goal')!.objects.first;
    add(Goal(
        size: Vector2(goal.width, goal.height),
        position: Vector2(goal.x, goal.y)));

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

    initializeGame(true);
  }

  Future<void> initializeGame(bool loadHud) async {
    camera.viewport = FixedResolutionViewport(Vector2(2368, mapHeight));
    camera.followComponent(lya,
        worldBounds: Rect.fromLTWH(0, 0, mapWidth, mapHeight),
        relativeOffset: const Anchor(0.05, 0.5));

    double startGroundHeight = groundObjects.first.height;
    Vector2 lyaSize = Vector2(320, 480);
    lya
      ..animation = standAnimation
      ..size = lyaSize
      ..position = Vector2(100, mapHeight - lyaSize.y - startGroundHeight);
    add(lya);

    if (loadHud) {
      // overlays.add('Hud');
    }
  }

  void reset() {
    overlays.add('StartMenu');
    gravity = 100;
    pushSpeed = 0;
    velocity = Vector2(0, 0);
    for (final obj in instrumentObjects) {
      if (obj.parent == null) {
        add(obj);
      }
    }
    remove(lya);
    lya = Lya();
    lya.animation = runAnimation;
    camera.moveTo(Vector2.all(0));
    camera.resetMovement();
    initializeGame(false);
  }

  void pauseGame() {
    pauseEngine();
    overlays.add('Pause');
  }

  void continueGame() {
    overlays.remove('Pause');
    resumeEngine();
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
