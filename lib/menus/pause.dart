import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamejam_baq_2023/main.dart';
import 'package:gamejam_baq_2023/menus/gameOver.dart';

class Pause extends StatefulWidget {
  const Pause({
    super.key,
    required this.game,
  });

  final GameJam2023 game;

  @override
  State<Pause> createState() => _PauseState();
}

class _PauseState extends State<Pause> {
  bool hint = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    hint = !hint;
    timer = Timer.periodic(Duration(seconds: 1), (e) {
      print("object");
      hint = !hint;
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
    final height = MediaQuery.sizeOf(context).height;
    final widht = MediaQuery.sizeOf(context).width;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          children: [
            Container(
              height: height / 1.5,
              width: widht / 2,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Color(0xFF15156a),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Container(
                      height: height / 1.65,
                      width: widht / 2.1,
                      decoration: BoxDecoration(
                          color: Color(0xFF233a8a),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                '~ Pause ~',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avigea',
                                  fontSize: 40,
                                ),
                              ),
                              CustomButtom(
                                onTap: () => widget.game.continueGame(),
                                title: "Continue",
                                icon: const Icon(
                                  Icons.skip_next_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                secondaryColor: Color(0xFF233a8a),
                                mainColor: Color(0xFF15156a),
                              ),
                              CustomButtom(
                                onTap: () {
                                  widget.game.reset();
                                  widget.game.overlays.remove('Pause');
                                },
                                title: "Restart",
                                icon: const Icon(
                                  Icons.restart_alt_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                secondaryColor: Color(0xFF233a8a),
                                mainColor: Color(0xFF15156a),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                right: 6,
                top: 2,
                child: AnimatedScale(
                  duration: Duration(seconds: 1),
                  scale: hint ? 0.1 : 1,
                  child: RotatedBox(
                      quarterTurns: !hint ? 1 : 3,
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 15,
                      )),
                )),
            Positioned(
                left: 6,
                bottom: 2,
                child: AnimatedScale(
                  duration: Duration(seconds: 1),
                  scale: !hint ? 0.1 : 1,
                  child: RotatedBox(
                      quarterTurns: !hint ? 1 : 3,
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 15,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
