import 'package:flutter/material.dart';

import '../main.dart';

class MobileControls extends StatelessWidget {
  final GameJam2023 game;
  const MobileControls({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
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
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/bateria.png'),
                  ),
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/flauta.png'),
                  ),
                  InstrumentSlot(
                    instrument: Image.asset('assets/images/gaita.png'),
                  ),
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
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ArrowButton(
                    icon: Icons.keyboard_arrow_down_rounded,
                  ),
                  _ArrowButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                  ),

                  // ActionButton(
                  //   arrowImage: Image.asset('assets/images/arrow-up.png'),
                  //   onTap: () {
                  //     if (game.lya.onGround) {
                  //       game.lya.onGround = false;
                  //       game.velocity.y -= 100;
                  //       game.lya.position.y -= 100;
                  //     }
                  //   },
                  // ),
                  // ActionButton(
                  //   arrowImage: Image.asset('assets/images/arrow-down.png'),
                  //   onTap: () {
                  //     game.velocity.x += 50;
                  //     game.update(1);
                  //     //  game.velocity.y += game.gravity;
                  //   },
                  // ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    super.key,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade400.withOpacity(0.5),
        shape: const CircleBorder(),
        padding: const EdgeInsets.only(top: 4),
        side: const BorderSide(
          width: 2.0,
          color: Colors.black,
        ),
      ),
      child: Icon(
        icon,
        size: 72,
        color: Colors.black45,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final Image arrowImage;
  final Function()? onTap;
  const ActionButton({
    super.key,
    required this.onTap,
    required this.arrowImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: Colors.blue,
        ),
        width: 120,
        height: 120,
        child: GestureDetector(onTap: onTap, child: arrowImage),
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
