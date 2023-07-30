import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/main.dart';

class VictoryMenu extends StatelessWidget {
  // Reference to parent game.
  final GameJam2023 game;

  const VictoryMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: GestureDetector(
          onTap: () {
            game.continueGame();
            game.reset();
            game.overlays.remove('Victory');
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You Win',
                  style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 30,
                    fontFamily: 'avigea',
                    letterSpacing: 7,
                  ),
                ),
                const Text(
                  'Tap to play again',
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
