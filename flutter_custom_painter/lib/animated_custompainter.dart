import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedCustomPainter extends StatefulWidget {
  const AnimatedCustomPainter({Key? key}) : super(key: key);

  @override
  AnimatedCustomPainterState createState() => AnimatedCustomPainterState();
}

class AnimatedCustomPainterState extends State<AnimatedCustomPainter> with TickerProviderStateMixin {
  late Animation<double> radiusAnimation;
  late Animation<double> rotationAnimation;

  late AnimationController radiusAnimationController;
  late AnimationController rotationAnimationController;

  final Tween<double> _rotationTween = Tween(begin: -math.pi, end: math.pi);
  final Tween<double> _radiusTween = Tween(begin: 0.0, end: 100);

  @override
  void initState() {
    super.initState();

    radiusAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    rotationAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));

    radiusAnimation = _radiusTween.animate(radiusAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          radiusAnimationController.repeat();
        } else {
          radiusAnimationController.forward();
        }
      });

    rotationAnimation = _rotationTween.animate(rotationAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          rotationAnimationController.repeat();
        } else {
          rotationAnimationController.forward();
        }
      });

    radiusAnimationController.forward();
    rotationAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    radiusAnimationController.dispose();
    rotationAnimationController.dispose();
  }

  double _sides = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: rotationAnimation,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: ShapePainter(
                      sides: _sides,
                      radius: radiusAnimationController.value,
                      radians: rotationAnimationController.value),
                );
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          Slider(
            value: _sides,
            min: 3.0,
            max: 10.0,
            label: _sides.toInt().toString(),
            divisions: 7,
            onChanged: (value) {
              setState(() {
                _sides = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;
  ShapePainter({required this.sides, required this.radius, required this.radians});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();

    var angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint = Offset(radius * math.cos(radians), radius * math.sin(radians));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(radians + angle * i) + center.dx;
      double y = radius * math.sin(radians + angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
