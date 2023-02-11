// https://www.youtube.com/watch?v=-LAXoH7hL_M&t=613s

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FloatingBubbles extends StatelessWidget {
  const FloatingBubbles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: const [AnimWidget()],
        ),
      ),
    );
  }
}

class AnimWidget extends StatefulWidget {
  const AnimWidget({Key? key}) : super(key: key);

  @override
  _AnimWidgetState createState() => _AnimWidgetState();
}

class _AnimWidgetState extends State<AnimWidget> {
  late Timer timer;

  final particles = List.generate(300, (index) => Particle());

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        for (var element in particles) {
          element.pos += Offset(element.dx, element.dy);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomBubblePainter(particles: particles),
      child: Container(),
    );
  }
}

class CustomBubblePainter extends CustomPainter {
  final List<Particle> particles;

  CustomBubblePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      canvas.drawCircle(
          particle.pos,
          particle.radius,
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
  late double radius;
  late Color color;
  late double dx;
  late double dy;
  late Offset pos;

  Particle() {
    radius = Utils.inRange(3, 20);
    color = colors[Utils.inRange(0, 5).floor()];
    pos = Offset(Utils.inRange(0, 400), Utils.inRange(0, 700));
    dx = Utils.inRange(-0.1, 0.1);
    dy = Utils.inRange(-0.1, 0.1);
  }
}

class Utils {
  static double inRange(double min, double max) =>
      Random().nextDouble() * (max - min) + min;
}

List<Color> colors = [
  Colors.green,
  Colors.red,
  Colors.blue,
  Colors.yellow,
  Colors.white,
  Colors.greenAccent
];
