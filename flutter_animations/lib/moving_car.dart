import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// inspired from https://www.youtube.com/watch?v=0myixPv8ep8
// added animation for trees instead of using setState

class MovingCar extends StatefulWidget {
  const MovingCar({super.key});

  @override
  State<MovingCar> createState() => _MovingCarState();
}

class _MovingCarState extends State<MovingCar> with TickerProviderStateMixin {
  double bottomHeight = 50;
  double moveX = 50;

  ValueNotifier<bool> lightsOn = ValueNotifier(true);

  late AnimationController treeMotionController;
  late AnimationController carbounceController;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2E2D32),
      statusBarIconBrightness: Brightness.light,
    ));

    carbounceController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..repeat(reverse: true);

    treeMotionController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: false);

    treeMotionController.addListener(() {
      moveX += 5;
      //looping the move
      if (moveX >= MediaQuery.of(context).size.width) {
        moveX = -100;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets().bg),
                fit: BoxFit.cover,
                alignment: Alignment.centerRight),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  width: w,
                  height: h / 10,
                  color: const Color(0xFF261D37),
                ),
              ),
              AnimatedBuilder(
                  animation: treeMotionController,
                  builder: (context, child) {
                    return Positioned(
                      bottom: h / 10,
                      right: moveX,
                      child: Image.asset(
                        Assets().tree,
                        alignment: Alignment.center,
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: carbounceController,
                  builder: (context, child) {
                    return Positioned(
                      bottom: h / 10 + (carbounceController.value * 2),
                      child: SizedBox(
                        width: w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Spacer(),
                            Image.asset(
                              Assets().car,
                              alignment: Alignment.center,
                            ),
                            ValueListenableBuilder(
                              valueListenable: lightsOn,
                              builder: (context, _, __) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      lightsOn.value = !lightsOn.value;
                                    });
                                  },
                                  child: lightsOn.value
                                      ? SizedBox(
                                          width: w / 4,
                                          height: h / 40,
                                          child: CustomPaint(painter: DrawLight()),
                                        )
                                      : SizedBox(
                                          width: w / 4,
                                          height: h / 40,
                                        ),
                                );
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawLight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..shader = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.yellow.withOpacity(0.7), Colors.white.withOpacity(0.6)])
          .createShader(Rect.fromCircle(center: const Offset(50, 15), radius: 10));

    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.relativeLineTo(-size.width + 50, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Assets {
  final String bg = 'assets/moving_car/bg.png';
  final String car = 'assets/moving_car/car.png';
  final String tree = 'assets/moving_car/tree.png';
}
