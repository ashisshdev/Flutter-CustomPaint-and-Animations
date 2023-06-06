import 'package:flutter/material.dart';

class Torch extends StatefulWidget {
  const Torch({super.key});

  @override
  TorchState createState() => TorchState();
}

String limbo = "assets/torch/limbo.jpg";
String l = "assets/torch/l.jpg";
String minato = "assets/torch/minato.png";
String ryuk = "assets/torch/ryuk.png";

class TorchState extends State<Torch> {
  double x = 0, y = 0;
  final radius = 120.0;
  bool lightOn = false;

  void _onPanUpdate(Offset offset) {
    setState(() {
      lightOn = true;
      x = offset.dx;
      y = offset.dy;
    });
  }

  void _onPanEnd(_) {
    setState(() {
      lightOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (val) => _onPanUpdate(val.localPosition),
        onPanUpdate: (val) => _onPanUpdate(val.localPosition),
        onPanEnd: _onPanEnd,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Image.asset(
                ryuk,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            ClipPath(
              clipper: lightOn ? LightClipper(x: x, y: y, radius: radius) : null,
              child: Container(
                color: Colors.black,
              ),
            ),
            const Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Touch the screen to turn on the light",
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path> {
  final double x, y;
  final double radius;
  LightClipper({required this.x, required this.y, required this.radius});

  @override
  Path getClip(Size size) {
    final circlePath = Path()
      ..addOval(Rect.fromCircle(center: Offset(x, y), radius: radius));
    final fullPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    return Path.combine(PathOperation.reverseDifference, circlePath, fullPath);
  }

  @override
  bool shouldReclip(LightClipper oldClipper) => x != oldClipper.x || y != oldClipper.y;
}
