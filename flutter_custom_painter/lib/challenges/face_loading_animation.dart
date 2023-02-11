import 'package:flutter/material.dart';

// inspired from
// https://www.instagram.com/p/CImw3UlgugR/

class FaceLoadingAnimation extends StatefulWidget {
  const FaceLoadingAnimation({Key? key}) : super(key: key);

  @override
  State<FaceLoadingAnimation> createState() =>
      _FaceLoadingAnimationState();
}

class _FaceLoadingAnimationState extends State<FaceLoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    firstAnimation = Tween<double>(begin: 50, end: 150).animate(
        CurvedAnimation(
            parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {}
      });

    secondController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    secondAnimation = Tween<double>(begin: 50, end: 150).animate(
        CurvedAnimation(
            parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    thirdController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    thirdAnimation = Tween<double>(begin: 50, end: 150).animate(
        CurvedAnimation(
            parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CustomPaint(
                  painter: FacePainter(),
                  size: const Size(150, 150),
                ),
              ),
              // const SizedBox(
              //   height: 50,
              // ),
              // SizedBox(
              //   child: CustomPaint(
              //     painter: FacePainter(),
              //     size: const Size(150, 150),
              //   ),
              // ),
              // const SizedBox(
              //   height: 50,
              // ),
              // SizedBox(
              //   child: CustomPaint(
              //     painter: FacePainter(),
              //     size: const Size(150, 150),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      //     body: Stack(
      //   children: [
      //     // Positioned(
      //     //     bottom: 0,
      //     //     child: SizedBox(
      //     //       height:
      //     //           MediaQuery.of(context).size.height,
      //     //       width: MediaQuery.of(context).size.width,
      //     //       child: WaveAnimation(
      //     //         color: Colors.lightBlueAccent
      //     //             .withOpacity(0.5),
      //     //       ),
      //     //     )),
      //     /// use multiple waves in a stack
      //     // Positioned(
      //     //     bottom: 0,
      //     //     child: SizedBox(
      //     //       height:
      //     //           MediaQuery.of(context).size.height,
      //     //       width: MediaQuery.of(context).size.width,
      //     //       child: WaveAnimation(
      //     //         color: Colors.blue.withOpacity(0.2),
      //     //         firstRiseStartMin: 1.2,
      //     //         secondRiseStartMax: 1.9,
      //     //         delay: 200,
      //     //       ),
      //     //     )),
      //     // Positioned(
      //     //     bottom: 0,
      //     //     child: SizedBox(
      //     //       height:
      //     //           MediaQuery.of(context).size.height,
      //     //       width: MediaQuery.of(context).size.width,
      //     //       child: WaveAnimation(
      //     //         color:
      //     //             Colors.lightBlue.withOpacity(0.5),
      //     //         firstRiseStartMax: 1.8,
      //     //         secondRiseStartMin: 1.4,
      //     //         delay: 400,
      //     //       ),
      //     //     )),
      //   ],
      // ),
    );
  }
}

class FacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke;

    final a = const Offset(0, 0);
    final b = const Offset(50, 50);
    final rect = Rect.fromPoints(a, b);
    final roundedRect =
        RRect.fromRectAndRadius(rect, const Radius.circular(100));
    canvas.drawRRect(roundedRect, paint);

    final c = const Offset(100, 0);
    final d = const Offset(150, 50);
    final rect2 = Rect.fromPoints(c, d);
    final roundedRect2 =
        RRect.fromRectAndRadius(rect2, const Radius.circular(100));
    canvas.drawRRect(roundedRect2, paint);

    final e = const Offset(0, 100);
    final f = const Offset(50, 150);
    final rect3 = Rect.fromPoints(e, f);
    final roundedRect3 =
        RRect.fromRectAndRadius(rect3, const Radius.circular(100));
    canvas.drawRRect(roundedRect3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// we need a logic for

int x1 = 0;
int y1 = 0;
int x2 = 50;
int y2 = 50;
bool someBool1 = true;
bool someBool2 = true;
increment() {}
