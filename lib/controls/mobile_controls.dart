import 'dart:async' as async;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MobileControls extends StatefulWidget {
  final GameJam2023 game;
  const MobileControls({
    super.key,
    required this.game,
  });

  @override
  State<MobileControls> createState() => _MobileControlsState();
}

class _MobileControlsState extends State<MobileControls> {
  async.Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = async.Timer.periodic(Duration(milliseconds: 100), (e) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...widget.game.instrumentsCollected.entries
                      .map((value) => value.value
                          ? Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/instruments/${value.key}.png",
                                width: 40,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/instruments/${value.key}_black.png",
                                width: 40,
                              ),
                            )),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () => widget.game.pauseGame(),
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
                      if (widget.game.lya.onGoalReached ||
                          widget.game.lya.onDead) {
                        return;
                      }
                      double startGroundHeight =
                          widget.game.groundObjects.first.height;
                      Vector2 lyaSize = Vector2(480, 320);
                      widget.game.lya.animation = widget.game.slideAnimation;
                      widget.game.lya.size = lyaSize;
                      widget.game.lya.position = Vector2(
                          widget.game.lya.position.x,
                          widget.game.mapHeight -
                              lyaSize.y -
                              startGroundHeight);
                      Future.delayed(const Duration(milliseconds: 600), () {
                        widget.game.lya.animation = widget.game.runAnimation;
                        Vector2 lyaSize = Vector2(320, 480);
                        widget.game.lya.animation = widget.game.runAnimation;
                        widget.game.lya.size = lyaSize;
                        widget.game.lya.position = Vector2(
                            widget.game.lya.position.x,
                            widget.game.mapHeight -
                                lyaSize.y -
                                startGroundHeight);
                      });
                    },
                  ),
                  _ArrowButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                    onPressed: () {
                      if (widget.game.lya.onGoalReached ||
                          widget.game.lya.onDead) {
                        return;
                      }
                      if (widget.game.jumpCount >= 1) {
                        return;
                      }
                      widget.game.lya.onGround = false;
                      widget.game.lya.animation = widget.game.jumpAnimation;
                      widget.game.lya.y -= 200;
                      widget.game.velocity.y = -widget.game.jumpForce;
                      Future.delayed(const Duration(milliseconds: 600), () {
                        widget.game.lya.animation = widget.game.runAnimation;
                        widget.game.lya.size = Vector2(320, 480);
                      });
                      widget.game.jumpCount = 1;
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

class InstrumentHud extends StatelessWidget {
  const InstrumentHud({super.key, required this.instruments});
  final List instruments;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.withOpacity(0.8),
      ),
      child: Row(
        children: [...instruments],
      ),
    );
  }
}

Map json = {
  'sintetizador': false,
  'bateria': false,
  'microfono': false,
  'piano': false,
  'voz': false
};

class InstrumentSlot extends StatelessWidget {
  final Image instrument;
  const InstrumentSlot({
    required this.instrument,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.all(3),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: instrument,
    );
  }
}
