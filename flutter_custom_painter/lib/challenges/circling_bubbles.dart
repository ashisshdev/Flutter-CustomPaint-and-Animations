import 'dart:math' as math;

import 'package:flutter/material.dart';

class CirculingBubbles extends StatefulWidget {
  const CirculingBubbles({Key? key}) : super(key: key);

  @override
  State<CirculingBubbles> createState() => _CirculingBubblesState();
}

class _CirculingBubblesState extends State<CirculingBubbles>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController rotationAnimationController;

  List<Particle> particles = [];

  int numberOfParticles = 150;
  int minimumSize = 1;
  int maximumSize = 20;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfParticles; i++) {
      //
      int randomParticleSize = randomInRange(max: maximumSize, min: minimumSize);

      //
      int randomR = randomInRange(max: 256);
      int randomB = randomInRange(max: 256);
      int randomG = randomInRange(max: 256);
      Color randomColor = Color.fromRGBO(randomR, randomG, randomB, 1.0);

      //
      int randomDistanceFromCenter = randomInRange(max: 100);

      //
      double randomAngleFromCenter = math.Random().nextDouble() * (2 * math.pi);

      particles.add(
        Particle(
            size: double.parse(randomParticleSize.toString()),
            color: randomColor,
            startingAngle: randomAngleFromCenter,
            distanceFromCenter: double.parse(randomDistanceFromCenter.toString())),
      );
    }

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7));

    rotationAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 7))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rotationAnimationController.repeat();
            }
          });

    animationController
        .forward()
        .whenComplete(() => rotationAnimationController.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: rotationAnimationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: rotationAnimationController.value * (2 * math.pi),
            child: child,
          );
        },
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return CustomPaint(
              painter: MyParticlePainter(
                  particles: particles, animationValue: animationController.value),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  MyParticlePainter({required this.particles, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // calculating final distance from center using radius
      final radius = particle.distanceFromCenter * animationValue * 8;

      final thetha = particle.startingAngle + animationValue * (2 * math.pi);

      double dx = radius * math.cos(thetha) + size.width / 2;
      double dy = radius * math.sin(thetha) + size.height / 2;

      if (!size.contains(Offset(dx, dy))) {
        continue;
      }

      canvas.drawCircle(
          Offset(dx, dy),
          particle.size,
          Paint()
            ..color = particle.color
            ..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  final double size;
  final Color color;
  final double startingAngle;
  final double distanceFromCenter;

  Particle({
    required this.size,
    required this.color,
    required this.startingAngle,
    required this.distanceFromCenter,
  });
}

// Helper Function
int randomInRange({int min = 0, required int max}) {
  return math.Random().nextInt(max) + min;
}
