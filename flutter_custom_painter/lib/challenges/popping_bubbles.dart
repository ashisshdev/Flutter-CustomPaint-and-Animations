// // inspired from
// // https://www.instagram.com/p/Cht6PYyDG7j/

// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';

// class PoppingBubbles extends StatefulWidget {
//   const PoppingBubbles({Key? key}) : super(key: key);

//   @override
//   State<PoppingBubbles> createState() => _BubblesAnimationState();
// }

// class _BubblesAnimationState extends State<PoppingBubbles>
//     with TickerProviderStateMixin {
//   late final AnimationController _controller1 = AnimationController(
//       vsync: this, duration: const Duration(milliseconds: 250))
//     ..repeat(reverse: true);

//   late final AnimationController _controller2 = AnimationController(
//       vsync: this, duration: const Duration(milliseconds: 350))
//     ..repeat(reverse: true);

//   late final AnimationController _controller3 = AnimationController(
//       vsync: this, duration: const Duration(milliseconds: 450))
//     ..repeat(reverse: true);

//   int slider = 2;
//   double minSize = 1;
//   double maxSize = 25;

//   late final particles1 = List.generate(33 * slider,
//       (index) => Particle(heightOfScreen: 800, widthOfScreen: 500));
//   late final particles2 = List.generate(33 * slider,
//       (index) => Particle(heightOfScreen: 800, widthOfScreen: 500));
//   late final particles3 = List.generate(33 * slider,
//       (index) => Particle(heightOfScreen: 800, widthOfScreen: 500));

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
//       setState(() {
//         for (int i = 0; i < 33 * slider; i++) {
//           /// Operations on first list of particles
//           particles1[i].radius = _controller1.value * 5;
//           // Change positions
//           if (particles1[i].radius < 0.1) {
//             // element.color = colors[Utils.inRange(1, 3).floor()];
//             if (particles1[i].pos.dx < 500 && particles1[i].pos.dy < 600) {
//               particles1[i].pos +=
//                   Offset(Utils.inRange(-100, 100), Utils.inRange(-100, 100));
//             } else {
//               particles1[i].pos -=
//                   Offset(Utils.inRange(-100, 100), Utils.inRange(-100, 100));
//             }
//           }

//           /// Operations on second list of particles
//           particles2[i].radius = _controller2.value * 5;
//           // Change positions
//           if (particles2[i].radius < 0.1) {
//             // element.color = colors[Utils.inRange(1, 3).floor()];
//             if (particles2[i].pos.dx < 500 && particles2[i].pos.dy < 600) {
//               particles2[i].pos +=
//                   Offset(Utils.inRange(-100, 100), Utils.inRange(-100, 100));
//             } else {
//               particles2[i].pos -=
//                   Offset(Utils.inRange(-100, 100), Utils.inRange(-100, 100));
//             }
//           }

//           /// Operations on first list of particles
//           particles3[i].radius = _controller3.value * 5;
//           // Change positions
//           if (particles3[i].radius < 0.1) {
//             // element.color = colors[Utils.inRange(1, 3).floor()];
//             if (particles3[i].pos.dx < 500 && particles3[i].pos.dy < 600) {
//               particles3[i].pos +=
//                   Offset(Utils.inRange(-100, 100), Utils.inRange(-100, 100));
//             } else {
//               particles3[i].pos -=
//                   Offset(Utils.inRange(-100, 100), Utils.inRange(-100, 100));
//             }
//           }
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             AnimatedBuilder(
//                 animation: _controller1,
//                 builder: (context, _) {
//                   return RepaintBoundary(
//                     child: CustomPaint(
//                       painter: CustomBubblePainter(particles: particles1),
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: MediaQuery.of(context).size.height,
//                         width: MediaQuery.of(context).size.width,
//                       ),
//                     ),
//                   );
//                 }),
//             AnimatedBuilder(
//                 animation: _controller2,
//                 builder: (context, _) {
//                   return RepaintBoundary(
//                     child: CustomPaint(
//                       painter: CustomBubblePainter(particles: particles2),
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: MediaQuery.of(context).size.height,
//                         width: MediaQuery.of(context).size.width,
//                       ),
//                     ),
//                   );
//                 }),
//             AnimatedBuilder(
//                 animation: _controller3,
//                 builder: (context, _) {
//                   return RepaintBoundary(
//                     child: CustomPaint(
//                       painter: CustomBubblePainter(particles: particles3),
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: MediaQuery.of(context).size.height,
//                         width: MediaQuery.of(context).size.width,
//                       ),
//                     ),
//                   );
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomBubblePainter extends CustomPainter {
//   final List<Particle> particles;

//   CustomBubblePainter({required this.particles});

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var particle in particles) {
//       canvas.drawCircle(
//           particle.pos,
//           particle.radius * 10,
//           Paint()
//             ..color = particle.color
//             ..style = PaintingStyle.fill);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class Particle {
//   final int minRadius;
//   final int maxRadius;
//   late double radius;
//   late Color color;
//   // height width required to calculate offsets
//   final double heightOfScreen;
//   final double widthOfScreen;
//   late double dx;
//   late double dy;
//   late Offset pos;

//   Particle(
//       {required this.heightOfScreen,
//       required this.widthOfScreen,
//       required this.minRadius,
//       required this.maxRadius}) {
//     radius = Utils.inRange(3, 20);
//     color = colors[Utils.inRange(0, 1).floor()];
//     pos = Offset(
//         Utils.inRange(0, widthOfScreen), Utils.inRange(0, heightOfScreen));
//     dx = Utils.inRange(-0.1, 0.1);
//     dy = Utils.inRange(-0.1, 0.1);
//   }
// }

// class Utils {
//   static double inRange(double min, double max) =>
//       Random().nextDouble() * (max - min) + min;
// }

// List<Color> colors = [
//   Colors.green,
//   Colors.red,
//   Colors.blue,
//   Colors.yellow,
//   Colors.white,
//   Colors.greenAccent
// ];
