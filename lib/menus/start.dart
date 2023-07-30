import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/main.dart';

class StartMenu extends StatelessWidget {
  // Reference to parent game.
  final GameJam2023 game;

  const StartMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: GestureDetector(
          onTap: () {
            game.pushSpeed = 18;
            game.lya.animation = game.runAnimation;
            game.overlays.remove('StartMenu');
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Collect all instruments and coins',
                  style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 30,
                    fontFamily: 'avigea',
                    letterSpacing: 7,
                  ),
                ),
                const Text(
                  'Tap to play',
                  style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 60,
                    fontFamily: 'avigea',
                    letterSpacing: 7,
                  ),
                ),
                Image.asset(
                  'assets/images/tap.png',
                  color: Colors.white,
                  width: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
