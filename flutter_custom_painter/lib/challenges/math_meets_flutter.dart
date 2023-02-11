import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CubiclesWave extends StatefulWidget {
  const CubiclesWave({Key? key}) : super(key: key);

  @override
  State<CubiclesWave> createState() => _CubiclesWaveState();
}

class _CubiclesWaveState extends State<CubiclesWave>
    with SingleTickerProviderStateMixin {
  late Offset offset;

  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);
    offset = Offset.zero;

    animationController.addListener(() {
      setState(() {});
      print(animationController.value.toString());
//      dev.log();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            offset = details.localPosition;
            // animationController.forward();
            // if (!animationController.isAnimating) {
            //   if (!animationController.isCompleted) {
            //     // animationController.reverse();
            //     animationController.reverse();
            //   }else{
            //       animationController.reverse();

            //   }
            // }
          });
        },
        child: CustomPaint(
          painter: CubiclesWavePainter(
            // offset: offset,
            animationValue: Tween<double>(begin: 0.0, end: 1.0)
                .chain(
                  CurveTween(
                    curve: Curves.slowMiddle,
                  ),
                )
                .animate(animationController)
                .value,
          ),
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }
}

class CubiclesWavePainter extends CustomPainter {
  final double animationValue;

  CubiclesWavePainter({
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const imaginarySizeOfCubic = 20;
    final horizontalBlocks = size.width ~/ imaginarySizeOfCubic;
    final verticalBlocks = size.height ~/ imaginarySizeOfCubic;
    const maxWaveHeight = 100;
    const baseCubicSize = 10;

    for (var i = 0; i < horizontalBlocks; i++) {
      final itemValue = i / horizontalBlocks;
      const circleDiameter = 0.2;
      final isInRange = itemValue >= animationValue - circleDiameter / 2 &&
          itemValue <= animationValue + circleDiameter / 2;

      final isAhead = itemValue >= animationValue;
      final isBehind = itemValue <= animationValue;

      final blockValueWithinCircle =
          (animationValue + (circleDiameter / 2)) - itemValue;
      final highValue = !isAhead
          ? 1.0 - (blockValueWithinCircle / circleDiameter)
          : !isBehind
              ? blockValueWithinCircle / circleDiameter
              : itemValue == animationValue
                  ? 1.0
                  : 0.0;
      for (var j = 0; j < verticalBlocks; j++) {
        final randomValue = (i) / (horizontalBlocks);
        final paint = Paint()
          ..color = Colors.blue.withGreen(
            (255 * randomValue).toInt(),
          );
        final rect = Rect.fromLTWH(
          i * imaginarySizeOfCubic.toDouble(),
          j * imaginarySizeOfCubic -
              (isInRange ? highValue * maxWaveHeight : 0),
          baseCubicSize * highValue,
          baseCubicSize * highValue,
        );
        canvas.drawRect(
          rect,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

////////////////

class MarchingAnts extends StatefulWidget {
  const MarchingAnts({Key? key}) : super(key: key);

  @override
  State<MarchingAnts> createState() => _MarchingAntsState();
}

class _MarchingAntsState extends State<MarchingAnts>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(300, 300),
                  painter: MarchingAntsPainter(
                    animation.value,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MarchingAntsPainter extends CustomPainter {
  MarchingAntsPainter(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final outerLayer = Path()
      ..moveTo(value * 50, size.height / 2)
      ..lineTo(size.width * 0.25, size.height / 2)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width * 0.75, size.height / 2)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * 0.75, size.height)
      ..lineTo(size.width * 0.25, size.height)
      ..lineTo(0, size.height / 2)
      ..lineTo(value * 50, size.height / 2);

//outer layer
    Path dashPath = Path();

    double dashWidth = 10.0;
    double dashSpace = 5.0;
    double distance = 0;

    for (PathMetric pathMetric in outerLayer.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(
            distance,
            distance + dashWidth,
          ),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
    //finish
//inner layer
    final size2 = Size(size.width * 0.9, size.width * 0.9);
    final innerLayer = Path()
      ..moveTo(value * 50, size2.height / 2)
      ..lineTo(size2.width * 0.25, size2.height / 2)
      ..lineTo(size2.width / 2, 0)
      ..lineTo(size2.width * 0.75, size2.height / 2)
      ..lineTo(size2.width, size2.height / 2)
      ..lineTo(size2.width * 0.75, size2.height)
      ..lineTo(size2.width * 0.25, size2.height)
      ..lineTo(0, size2.height / 2)
      ..lineTo(value * 50, size2.height / 2);
    final shiftedLayer = innerLayer.shift(const Offset(15, 20));
    Path dashPath2 = Path();

    double distance2 = 0;

    for (PathMetric pathMetric in shiftedLayer.computeMetrics()) {
      while (distance2 < pathMetric.length) {
        dashPath2.addPath(
          pathMetric.extractPath(
            distance2,
            distance2 + dashWidth,
          ),
          Offset.zero,
        );
        distance2 += dashWidth;
        distance2 += dashSpace;
      }
    }

    canvas.drawPath(dashPath2, paint);
    //finish
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/////////////////

class EnlightenedHeart extends StatefulWidget {
  const EnlightenedHeart({Key? key}) : super(key: key);

  @override
  State<EnlightenedHeart> createState() => _EnlightenedHeartState();
}

class _EnlightenedHeartState extends State<EnlightenedHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomPaint(
        painter: EnlightenedHeartPainter(
          animationValue: animationController.value,
          angleValue:
              Tween(begin: 0.0, end: pi * 2).animate(animationController).value,
        ),
        size: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

class EnlightenedHeartPainter extends CustomPainter {
  EnlightenedHeartPainter({
    required this.animationValue,
    required this.angleValue,
  });

  final double animationValue;
  final double angleValue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    const baseAngle = pi * 2 / 360;
    const visibleArc = baseAngle * 45;
    const edgeCaseAngle = 360 * baseAngle - visibleArc;
    double startAngle = angleValue;

    double endAngle = angleValue + visibleArc;
    const double heartRadius = 10;

    // Drawing group of circles which represent the  visible portion of hearts arc as animation progresses

    final angle = calculateAngleBasedOnPoints(360);

    final circlesGroup1 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    for (var i = 0; i < 360; i++) {
      //calculate the angle of point
      double pointAngleValue = angle * i;

      //check if pointAngleValue lies within start and end angle

      bool isInRange = checkIfPointInRange(
        pointAngleValue: pointAngleValue,
        startAngle: startAngle,
        endAngle: endAngle,
      );
      if (!isInRange) {
        if (checkIfAngleGreaterThanEdgeCase(angle, edgeCaseAngle)) {
          isInRange = checkIfPointInRange(
            pointAngleValue: pointAngleValue + angle * 360,
            startAngle: startAngle,
            endAngle: endAngle,
          );
        }
      }

      if (isInRange) {
        canvas.drawCircle(
          calculatePointOffset(angle: pointAngleValue, radius: heartRadius),
          0.2,
          circlesGroup1,
        );
      }
    }

    // Drawing flickering small blue circles on the heart

    final circlesGroup2 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    final angle2 = calculateAngleBasedOnPoints(45);

    for (var i = 0; i < 45; i++) {
      //calculate the angle of point
      double pointAngleValue = angle2 * i;

      //check if pointAngleValue lies within start and end angle

      bool isInRange = checkIfPointInRange(
        pointAngleValue: pointAngleValue,
        startAngle: startAngle,
        endAngle: endAngle,
      );
      if (!isInRange) {
        if (checkIfAngleGreaterThanEdgeCase(angle2, edgeCaseAngle)) {
          isInRange = checkIfPointInRange(
            pointAngleValue: pointAngleValue + angle * 360,
            startAngle: startAngle,
            endAngle: endAngle,
          );
        }
      }

      if (true) {
        final shouldFlicker = Random().nextBool();

        canvas.drawCircle(
          calculatePointOffset(angle: angle2 * i, radius: heartRadius),
          1 - animationValue + (shouldFlicker ? 0.9 : 0),
          circlesGroup2,
        );
      }
    }

    // Drawing flickering large blue circles on the heart

    final circlesGroup3 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    final angle3 = calculateAngleBasedOnPoints(10);

    for (var i = 0; i < 10; i++) {
      //calculate the angle of point
      double pointAngleValue = angle3 * i;

      //check if pointAngleValue lies within start and end angle

      bool isInRange = checkIfPointInRange(
        pointAngleValue: pointAngleValue,
        startAngle: startAngle,
        endAngle: endAngle,
      );

      if (!isInRange) {
        if (checkIfAngleGreaterThanEdgeCase(angle3, edgeCaseAngle)) {
          isInRange = checkIfPointInRange(
            pointAngleValue: pointAngleValue + angle * 360,
            startAngle: startAngle,
            endAngle: endAngle,
          );
        }
      }

      if (isInRange) {
        final shouldFlicker = Random().nextBool();

        canvas.drawCircle(
          calculatePointOffset(angle: angle3 * i, radius: heartRadius),
          3 + (shouldFlicker ? 0.7 : 0),
          circlesGroup3,
        );
      }
    }

    // Drawing group of circles which move along the  visible portion of hearts arc as animation progresses

    final circlesGroup4 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    for (var i = 0; i < 45; i++) {
      final updatedAngle = angleValue + 2.6 + (i / 10);
      canvas.drawCircle(
        calculatePointOffset(angle: updatedAngle, radius: heartRadius),
        i.toDouble() * 0.03,
        circlesGroup4,
      );
    }
  }

  bool checkIfPointInRange({
    required double pointAngleValue,
    required double startAngle,
    required double endAngle,
  }) {
    return pointAngleValue >= startAngle && pointAngleValue <= endAngle;
  }

  bool checkIfAngleGreaterThanEdgeCase(double angle, double edgeCaseAngle) {
    return angleValue >= edgeCaseAngle; //angle * 315;
  }

  double calculateAngleBasedOnPoints(int points) {
    return pi * 2 / points;
  }

  Offset calculatePointOffset({required double angle, required double radius}) {
    return Offset(
      16 * pow(sin(angle), 3) * radius,
      -radius *
          (13 * cos(angle) -
              5 * cos(angle * 2) -
              2 * cos(angle * 3) -
              cos(angle * 4)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

////////////////////

class ClockWork extends StatefulWidget {
  const ClockWork({Key? key}) : super(key: key);

  @override
  State<ClockWork> createState() => _ClockWorkState();
}

class _ClockWorkState extends State<ClockWork>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 10,
      ),
    )..repeat(reverse: true);
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            painter: ClockWorkPainter(
              animationValue: animationController
                  .drive<double>(
                      Tween<double>(begin: 0, end: 1).chain(CurveTween(
                    curve: Curves.easeInOutExpo,
                  )))
                  .value,
            ),
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
          ),
        ],
      ),
    );
  }
}

class ClockWorkPainter extends CustomPainter {
  ClockWorkPainter({
    required this.animationValue,
  });

  final double animationValue;

  @override
  void paint(Canvas canvas, Size size) {
    final paint2 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    const double innerLines = 6;
    const double radius = 15.0;
    final Offset center = Offset(size.width / 2, size.height / 2);
    const circles = 12;
    for (var i = 1; i <= circles; i++) {
      final circleBrush = Paint()
        ..shader = RadialGradient(colors: [
          Colors.blue.withOpacity(0.1 * animationValue),
          Colors.red.withOpacity(0.1 * animationValue),
          Colors.purple.withOpacity(0.5 * animationValue),
        ], stops: const [
          0.0,
          0.6,
          0.9,
        ]).createShader(
          Rect.fromCircle(
            center: center,
            radius: radius * i,
          ),
        )
        ..style = PaintingStyle.fill;

      final angle = (pi * 2) / (innerLines * i);
      // final updatedAngle = angle + angle * 0.1;
      if (i < circles) {
        for (var j = 1; j <= innerLines * i; j++) {
          // final cosAngle = cos(angle * j + animationValue * i);
          // final sinAngle = sin(angle * j + animationValue * i);
          final cosAngle = cos(angle * j + animationValue * i);
          final sinAngle = sin(angle * j + animationValue * i);
          final innerCircleRadius = radius * i;
          final outerCircleRadius = radius * (i + 1);

          final x = size.width / 2 + cosAngle * innerCircleRadius;
          final y = size.height / 2 + sinAngle * innerCircleRadius;
          final startingPoint = Offset(x, y);
          final x2 = size.width / 2 + cosAngle * outerCircleRadius;
          final y2 = size.height / 2 + sinAngle * outerCircleRadius;
          final endPoint = Offset(x2, y2);
          canvas.drawLine(startingPoint, endPoint, paint2);
          canvas.drawCircle(endPoint, 2, paint2);
        }
      }

      canvas.drawCircle(center, radius * i, circleBrush);
      // canvas.drawRect(
      //   Rect.fromCircle(center: center, radius: radius * i),
      //   circleBrush,
      // );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
