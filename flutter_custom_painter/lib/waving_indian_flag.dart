// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class WavingIndianFlag extends StatelessWidget {
  const WavingIndianFlag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9933),
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
              bottom: 90,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WaterFlowAnimation(
                    color: Colors.white, height1: 2.3, height2: 2.1),
              )),
          Positioned(
              top: 220,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WaterFlowAnimation(
                    color: Color(0xFF138808), height1: 2.3, height2: 2.1),
              )),
          Center(
              child: Image.asset(
            'assets/waving_indian_flag/ashoka.png',
            height: 200,
            width: 200,
          )),
        ],
      )),
    );
  }
}

/// courtesy of Ravi Patel Bro IG @bugs_fixes

class WaterFlowAnimation extends StatefulWidget {
  final Color color;
  final double height1;
  final double height2;

  const WaterFlowAnimation(
      {super.key,
      required this.color,
      required this.height1,
      required this.height2});

  @override
  State<WaterFlowAnimation> createState() => _HomePageState();
}

class _HomePageState extends State<WaterFlowAnimation>
    with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    firstAnimation =
        Tween<double>(begin: widget.height1, end: widget.height1 + 0.2).animate(
      CurvedAnimation(parent: firstController, curve: Curves.easeInOut),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              firstController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              firstController.forward();
            }
          });

    secondController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    secondAnimation =
        Tween<double>(begin: widget.height2, end: widget.height2 + 0.6).animate(
      CurvedAnimation(parent: secondController, curve: Curves.easeInOut),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              secondController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              secondController.forward();
            }
          });

    thirdController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    thirdAnimation =
        Tween<double>(begin: widget.height2, end: widget.height2 + 0.6).animate(
      CurvedAnimation(parent: thirdController, curve: Curves.easeInOut),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              thirdController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              thirdController.forward();
            }
          });

    fourthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    fourthAnimation =
        Tween<double>(begin: widget.height1, end: widget.height1 + 0.2).animate(
      CurvedAnimation(parent: fourthController, curve: Curves.easeInOut),
    )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              fourthController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              fourthController.forward();
            }
          });

    Timer(const Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(const Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomPaint(
      painter: MyPainter(firstAnimation.value, secondAnimation.value,
          thirdAnimation.value, fourthAnimation.value, widget.color),
      child: SizedBox(height: size.height, width: size.width),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;
  final Color color;

  MyPainter(this.firstValue, this.secondValue, this.thirdValue,
      this.fourthValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(
        size.width * .4,
        size.height / secondValue,
        size.width * .7,
        size.height / thirdValue,
        size.width,
        size.height / fourthValue,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
