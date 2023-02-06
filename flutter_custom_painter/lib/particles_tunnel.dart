// https://www.instagram.com/p/CP-v_AkjJWw/

// ignore_for_file: avoid_print

import 'dart:math' as math;

// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class ParticlesTunnel extends StatefulWidget {
  const ParticlesTunnel({Key? key}) : super(key: key);

  @override
  State<ParticlesTunnel> createState() => ParticlesTunnelState();
}

class ParticlesTunnelState extends State<ParticlesTunnel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: ((context, child) {
                return SizedBox(
                  height: 400,
                  width: 400,
                  child: CustomPaint(
                    painter: MyParticlePainter(
                        animationValue: _controller.value, numberOfParticles: 10),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class MyParticlePainter extends CustomPainter {
  final double animationValue;
  final int numberOfParticles;

  MyParticlePainter({required this.animationValue, required this.numberOfParticles});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final Offset targetOffset = Offset(w / 2, h / 2);

    double lineLength = 25;

    double lineAwayFromCenter = 100;
    double randomAngleFromCenter = math.Random().nextDouble() * 2 * math.pi;

    double randomXCordinate = lineAwayFromCenter + math.cos(randomAngleFromCenter);
    double randomYCordinate = lineAwayFromCenter + math.sin(randomAngleFromCenter);
    Offset randomOffsetLineStart = Offset(randomXCordinate, randomYCordinate);
    Offset randomOffsetLineEnd =
        Offset(lineLength + randomXCordinate, lineLength + randomYCordinate);

    canvas.drawLine(
        randomOffsetLineStart,
        randomOffsetLineEnd,
        Paint()
          ..color = Colors.green
          ..strokeCap = StrokeCap.square
          ..strokeWidth = 5);
  }

  // @override
  // void paint(Canvas canvas, Size size) {
  //   final w = size.width;
  //   final h = size.height;

  //   for (int i = 0; i < numberOfParticles; i++) {
  //     //
  //     double tempRadius = (i * 20) + (animationValue * 1);
  //     print("temporaty radius = ");
  //     print(tempRadius);

  //     //
  //     double randomTheta = math.Random().nextDouble() * 2 * math.pi;
  //     print("random Theta = ");
  //     print(randomTheta);

  //     //
  //     Offset tempStartingOffset = Offset(w / 2 + tempRadius * math.cos(randomTheta),
  //         w / 2 + tempRadius * math.sin(randomTheta));
  //     // particle length so we can tell canvas to draw line from offset1 to offset2 , we add particle size to offset2
  //     int particleLength = i;
  //     Offset tempEndingOffset = Offset(
  //         particleLength + w / 2 + tempRadius * math.cos(randomTheta),
  //         particleLength + w / 2 + tempRadius * math.sin(randomTheta));

  //     print("temp starting and ending offsets = ");
  //     print("$tempEndingOffset and $tempEndingOffset");

  //     if (size.contains(tempEndingOffset)) {
  //       canvas.drawLine(
  //           tempStartingOffset,
  //           tempEndingOffset,
  //           Paint()
  //             ..color = Colors.green
  //             ..strokeCap = StrokeCap.round
  //             ..strokeWidth = 3);
  //     }
  //   }
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
