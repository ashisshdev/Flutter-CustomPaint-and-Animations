//  inspired from https://www.instagram.com/p/CjYZaTDD4yq/

import 'dart:math';

import 'package:flutter/material.dart';

class MesmerizingSticks extends StatefulWidget {
  const MesmerizingSticks({Key? key}) : super(key: key);

  @override
  State<MesmerizingSticks> createState() => _MesmerizingSticksState();
}

class _MesmerizingSticksState extends State<MesmerizingSticks>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: 0.0,
        upperBound: 1)
      ..repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: AnimatedBuilder(
              animation: _controller,
              child: Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                color: Colors.green,
                height: 2,
                width: 10,
              ),
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 19; i++) ...[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = 0; j < 60; j++) ...[
                            Transform.rotate(
                              angle:
                                  (_controller.value + (i + j) / 75) *
                                      2 *
                                      pi,
                              child: child,
                            )
                          ]
                        ],
                      )
                    ],
                  ],
                );
              })),
    );
  }
}
