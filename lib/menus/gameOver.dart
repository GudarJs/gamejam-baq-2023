import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/main.dart';

import '../customs/custom_buttom.dart';

class GameOver extends StatelessWidget {
  // Reference to parent game.
  final GameJam2023 game;

  const GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final blackTextColor = Colors.black.withOpacity(0.8);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: blackTextColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game Over',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 70,
                  fontFamily: 'avigea',
                  letterSpacing: 7,
                ),
              ),
              CustomButtom(
                onTap: () {
                  game.reset();
                  game.overlays.remove('GameOver');
                },
                title: "Try Again",
                icon: Icon(
                  Icons.restart_alt_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                secondaryColor: Color(0xFF15156a),
                mainColor: Color(0xFF233a8a),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
