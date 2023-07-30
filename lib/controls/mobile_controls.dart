import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
                  GestureDetector(
                    onTap: () => game.pauseGame(),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white24.withOpacity(0.8),
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.pause),
                    ),
                  ),
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
                      double startGroundHeight = game.groundObjects.first.height;
                      Vector2 lyaSize = Vector2(480, 320);
                      game.lya.animation = game.slideAnimation;
                      game.lya.size = lyaSize;
                      game.lya.position = Vector2(game.lya.position.x, game.mapHeight - lyaSize.y - startGroundHeight);
                      Future.delayed(const Duration(milliseconds: 400), () {
                        game.lya.animation = game.runAnimation;
                      Vector2 lyaSize = Vector2(320, 480);
                      game.lya.animation = game.runAnimation;
                      game.lya.size = lyaSize;
                      game.lya.position = Vector2(game.lya.position.x, game.mapHeight - lyaSize.y - startGroundHeight);
                      });
                    },
                  ),
                  _ArrowButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                    onPressed: () {
                      if (game.jumpCount >= 1) { return; }
                      game.lya.onGround = false;
                      game.lya.animation = game.jumpAnimation;
                      game.lya.y -= 200;
                      game.velocity.y = -game.jumpForce;
                      Future.delayed(const Duration(milliseconds: 400), () {
                        game.lya.animation = game.runAnimation;
                        game.lya.size = Vector2(320, 480);
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
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.shade400.withOpacity(0.4),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade600.withOpacity(0.4),
            // border: Border.all(width: 2),
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
