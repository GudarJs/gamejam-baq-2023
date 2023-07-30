import 'dart:async';

import 'package:flutter/material.dart';

class CustomButtom extends StatefulWidget {
  const CustomButtom({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.mainColor,
    required this.secondaryColor,
  });

  final Function()? onTap;
  final String title;
  final Icon icon;
  final Color mainColor;
  final Color secondaryColor;

  @override
  State<CustomButtom> createState() => _CustomButtomState();
}

class _CustomButtomState extends State<CustomButtom> {
  bool hint = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    hint = !hint;
    timer = Timer.periodic(Duration(seconds: 1), (e) {
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
    return Stack(
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: widget.secondaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  height: 45,
                  width: 200,
                  decoration: BoxDecoration(
                      color: widget.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 2, child: widget.icon),
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avigea',
                            fontSize: 23,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
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
                  child: const Icon(
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
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 15,
                  )),
            ))
      ],
    );
  }
}
