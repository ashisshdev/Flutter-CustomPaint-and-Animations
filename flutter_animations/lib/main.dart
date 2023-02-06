// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'hahaanimation.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.all(10),
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: TextButton(
//                   child: const Text("Go to animation"),
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AnimationPractice()));
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawLine(),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawArc(),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawLineByPath(),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawTriangle(),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawCircle(),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawRectangleFromPoints(),
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: CustomPaint(
//                   painter: DrawRectangleFromCenter(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DrawTriangle extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint trianglePaint = Paint()
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5
//       ..color = Colors.teal;

//     Path trianglePath = Path();
//     trianglePath.moveTo(size.width / 2, 0);
//     trianglePath.moveTo(size.width, size.height);
//     trianglePath.moveTo(size.width, 0);
//     trianglePath.close();

//     canvas.drawPath(trianglePath, trianglePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DrawArc extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint arcPaint = Paint()
//       ..strokeCap = StrokeCap.butt
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3
//       ..color = Colors.red;

//     Offset center = const Offset(10, 10);

//     Rect rect = Rect.fromCenter(center: center, width: size.width / 2, height: size.height / 2);

//     canvas.drawArc(rect, 90, 18, true, arcPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DrawLine extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double height = size.height;
//     final double width = size.width;

//     Paint linePaint = Paint()
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 12
//       ..color = Colors.black87;

//     Offset startingPoint = const Offset(10, 10);
//     Offset endingPoint = Offset(0, height);

//     canvas.drawLine(startingPoint, endingPoint, linePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DrawLineByPath extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double height = size.height;
//     final double width = size.width;

//     Paint linePaint = Paint()
//       ..color = Colors.green
//       ..strokeWidth = 20
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     Path linePath = Path();
//     linePath.moveTo(0, height / 2);
//     linePath.lineTo(0, 0);
//     canvas.drawPath(linePath, linePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DrawCircle extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint circlePaint = Paint()
//       ..strokeCap = StrokeCap.butt
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3
//       ..color = Colors.red;

//     Offset center = const Offset(10, 10);

//     canvas.drawCircle(center, 70, circlePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DrawRectangleFromPoints extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double height = size.height;
//     final double width = size.width;

//     Paint rectPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 9
//       ..color = Colors.blue;

//     Offset startingPoint = const Offset(0, 10);
//     Offset endingPoint = Offset(width, height);

//     Rect rect = Rect.fromPoints(startingPoint, endingPoint);

//     canvas.drawRect(rect, rectPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class DrawRectangleFromCenter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double height = size.height;
//     final double width = size.width;

//     Paint rectPaint = Paint()
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 9
//       ..color = Colors.green;

//     Offset startingPoint = const Offset(0, 10);
//     Offset endingPoint = Offset(width, height);

//     Rect rect = Rect.fromCenter(center: startingPoint, width: width / 2, height: height / 2);

//     canvas.drawRect(rect, rectPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // class MyCustomPainterChild extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     // line stuff
// //     var linePaint = Paint()
// //       ..color = Colors.red
// //       ..strokeWidth = 5
// //       ..strokeCap = StrokeCap.round;
// //
// //     Offset startingPoint = Offset(0, size.height / 2);
// //     Offset endingPoint = Offset(size.width, size.height / 2);
// //
// //     // circle stuff
// //     double radius = min(size.height, size.width) / 2;
// //     Offset center = Offset(size.height / 2, size.width / 2);
// //
// //     Paint circlePaint = Paint()
// //       ..color = Colors.green
// //       ..style = PaintingStyle.fill;
// //
// //     // line stuff with path
// //     var pathLinePaint = Paint()
// //       ..color = Colors.yellow
// //       ..strokeWidth = 5
// //       ..style = PaintingStyle.stroke
// //       ..strokeCap = StrokeCap.round;
// //
// //     var linePath = Path();
// //     linePath.moveTo(0, size.height / 4);
// //     linePath.lineTo(size.width, size.height / 4);
// //
// //     // draw circle using path
// //     var circlePath = Path();
// //     circlePath.addOval(Rect.fromCircle(center: Offset(size.height / 2, size.width / 2), radius: size.height / 2 - 20));
// //
// //     canvas.drawCircle(center, radius, circlePaint);
// //     canvas.drawLine(startingPoint, endingPoint, linePaint);
// //     canvas.drawPath(linePath, pathLinePaint);
// //     canvas.drawPath(circlePath, pathLinePaint);
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     return false;
// //   }
// // }
