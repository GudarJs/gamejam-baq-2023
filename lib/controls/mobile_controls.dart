import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../sounds/sound_effects.dart';

class MobileControls extends StatelessWidget {
  final GameJam2023 game;
  const MobileControls({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/arpa.png'),
                  ),
                  const SizedBox(width: 8),
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/bateria.png'),
                  ),
                  const SizedBox(width: 8),
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/flauta.png'),
                  ),
                  const SizedBox(width: 8),
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/gaita.png'),
                  ),
                  const SizedBox(width: 8),
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/sintetizador.png'),
                  ),
                  Expanded(child: Container()),
                  _PauseButton(
                    icon: Icons.pause,
                    onTap: () {
                      SoundEffects.pause();
                      // MusicTracks.pauseMusic(1);
                      game.bgmMain.pause();
                      game.pauseGame();
                    },
                  )
                  // GestureDetector(
                  //   onTap: () {
                  //     game.pauseGame();
                  //   },
                  //   child: Container(
                  //     width: 50,
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //         color: Colors.white24.withOpacity(0.8),
                  //         border: Border.all(width: 2),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child: const Icon(Icons.pause),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ArrowButton(
                    icon: Icons.keyboard_arrow_down_rounded,
                    onPressed: () {
                      if (game.lya.onGoalReached || game.lya.onDead) { return; }
                      SoundEffects.slide();

                      double startGroundHeight = game.groundObjects.first.height;
                      Vector2 lyaSize = Vector2(611 / 2, 227 / 2);
                      game.lya
                        ..animation = game.slideAnimation
                        ..size = lyaSize
                        ..position = Vector2(game.lya.position.x, game.mapHeight - lyaSize.y - startGroundHeight);
                      Future.delayed(const Duration(milliseconds: 600), () {
                        double startGroundHeight = game.groundObjects.first.height;
                        Vector2 lyaSize = Vector2(305 / 2, 419 / 2);
                        game.lya
                          ..animation = game.runAnimation
                          ..size = lyaSize
                          ..position = Vector2(game.lya.position.x, game.mapHeight - lyaSize.y - startGroundHeight);
                      });
                    },
                  ),
                  _ArrowButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                    onPressed: () {
                      if (game.lya.onGoalReached || game.lya.onDead) { return; }
                      if (game.jumpCount >= 1) { return; }
                      SoundEffects.jump();
                      game.lya.onGround = false;
                      double startGroundHeight = game.groundObjects.first.height;
                      Vector2 lyaSize = Vector2(280 / 2, 574 / 2);
                      game.lya
                        ..animation = game.jumpAnimation
                        ..size = lyaSize
                        ..position = Vector2(game.lya.position.x, game.mapHeight - lyaSize.y - startGroundHeight);
                      game.lya.y -= 200;
                      game.velocity.y = -game.jumpForce;
                      Future.delayed(const Duration(milliseconds: 600), () {
                        double startGroundHeight = game.groundObjects.first.height;
                        Vector2 lyaSize = Vector2(305 / 2, 419 / 2);
                        game.lya
                          ..animation = game.runAnimation
                          ..size = lyaSize
                          ..position = Vector2(game.lya.position.x, game.mapHeight - lyaSize.y - startGroundHeight);
                      });
                      game.jumpCount = 1;
                    },
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade400.withOpacity(0.4),
        shape: const CircleBorder(),
        padding: const EdgeInsets.only(top: 4),
      ),
      child: Icon(
        icon,
        size: 64,
        color: Colors.black38,
      ),
    );
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.shade400.withOpacity(0.4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade600.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.pause,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}

class InstrumentSlot extends StatelessWidget {
  final Image instrument;
  const InstrumentSlot({
    required this.instrument,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white24.withOpacity(0.8),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: instrument,
    );
  }
}
