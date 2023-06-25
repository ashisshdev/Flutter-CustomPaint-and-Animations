import 'package:flutter/material.dart';

class AlertDilalogScreen extends StatelessWidget {
  const AlertDilalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
            child: const Text("Open alert dialog"),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: const Color(0x01000000),
                builder: (BuildContext context) {
                  return Dialog(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      height: 290,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Stack(
                        children: [
                          const Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.close,
                                  size: 90,
                                ),
                              )),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 240,
                            child: ClipPath(
                              clipper: DialogClipper(),
                              child: Container(
                                  color: Colors.pink,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [Text("Dialog Content")],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class DialogClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final h = size.height;
    final w = size.width;
    final heightOnTop = h * 0.05;
    final path = Path()
      ..moveTo(0, heightOnTop)
      ..lineTo(w * 0.35, heightOnTop)
      ..arcToPoint(Offset(size.width * 0.65, heightOnTop),
          radius: Radius.circular(w * 0.15), clockwise: false)
      ..lineTo(w, heightOnTop)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..lineTo(0, heightOnTop);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
