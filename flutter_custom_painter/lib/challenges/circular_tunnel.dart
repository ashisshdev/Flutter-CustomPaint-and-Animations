import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularTunnel extends StatefulWidget {
  const CircularTunnel({Key? key}) : super(key: key);

  @override
  State<CircularTunnel> createState() => _CircularTunnelState();
}

class _CircularTunnelState extends State<CircularTunnel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 4))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: SizedBox(
                height: 400,
                width: 400,
                child: CustomPaint(
                  painter: MyCirclePainter(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 190; i > 30; i -= 10) {
      canvas.drawCircle(
          Offset(
            size.width / 2,
            double.parse((i - i ~/ 10).toString()),
          ),
          i - 20,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round
            ..strokeWidth = 3);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
