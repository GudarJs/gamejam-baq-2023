import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/main.dart';


class StartMenu extends StatelessWidget {
  // Reference to parent game.
  final GameJam2023 game;

  const StartMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
   const blackTextColor = Color.fromRGBO(136, 47, 163, 1);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 250,
          width: 300,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Colecciona notas y salva tu planta!',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    game.pushSpeed = 18;
                    game.lya.animation = game.runAnimation;
                    game.overlays.remove('StartMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Empezar',
                    style: TextStyle(
                      fontSize: 20,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}