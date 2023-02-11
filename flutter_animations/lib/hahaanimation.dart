import 'package:flutter/material.dart';

class AnimationPractice extends StatefulWidget {
  const AnimationPractice({Key? key}) : super(key: key);

  @override
  _AnimationPracticeState createState() => _AnimationPracticeState();
}

class _AnimationPracticeState extends State<AnimationPractice>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(
          vsync: this, duration: const Duration(seconds: 4))
        ..repeat(reverse: true);

  late final Animation<Offset> animation =
      Tween(begin: Offset.zero, end: const Offset(0.8, 0.8)).animate(
          CurvedAnimation(
              parent: animationController, curve: Curves.easeInOut));

  late final AnimationController animationController2 =
      AnimationController(
          vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<Color?> animation2 =
      ColorTween(begin: Colors.white, end: Colors.green).animate(
          CurvedAnimation(
              parent: animationController2,
              curve: Curves.bounceInOut));

  late final AnimationController animationController3 =
      AnimationController(
          vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<double> animation3 =
      Tween(begin: 0.0, end: 2.0).animate(animationController3);

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    animationController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("yolo"),
      ),
      backgroundColor: Colors.black87,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: animation,
              child: RotationTransition(
                turns: animation3,
                child: AnimatedBuilder(
                    animation: animationController2,
                    builder: (context, child) => Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(30),
                          color: animation2.value,
                          child: const SizedBox(
                            height: 200,
                            width: 200,
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
