import 'package:flutter/material.dart';

/// We use positioned widget and change its parameters based on scroll value from ScrollListener

class ParallaxOne extends StatefulWidget {
  const ParallaxOne({Key? key}) : super(key: key);

  @override
  ParallaxOneState createState() => ParallaxOneState();
}

class ParallaxOneState extends State<ParallaxOne> {
  double rateZero = 0;
  double rateOne = 0;
  double rateTwo = 0;
  double rateThree = 0;
  double rateFour = 0;
  double rateFive = 0;
  double rateSix = 0;
  double rateSeven = 0;
  double rateEight = 90;

  late String asset;
  late double top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            //only if scroll update notification is triggered
            setState(() {
              rateEight -= v.scrollDelta! / 1;
              rateSeven -= v.scrollDelta! / 1.5;
              rateSix -= v.scrollDelta! / 2;
              rateFive -= v.scrollDelta! / 2.5;
              rateFour -= v.scrollDelta! / 3;
              rateThree -= v.scrollDelta! / 3.5;
              rateTwo -= v.scrollDelta! / 4;
              rateOne -= v.scrollDelta! / 4.5;
              rateZero -= v.scrollDelta! / 5;
            });
          }
          return true;
        },
        child: Stack(
          children: <Widget>[
            ParallaxWidget(top: rateZero, color: Colors.red),
            ParallaxWidget(top: rateOne, color: Colors.yellow),
            ParallaxWidget(top: rateTwo, color: Colors.green),
            ParallaxWidget(top: rateThree, color: Colors.blue),
            ParallaxWidget(top: rateFour, color: Colors.black),
            ParallaxWidget(top: rateFive, color: Colors.red),
            ParallaxWidget(top: rateSix, color: Colors.yellow),
            ParallaxWidget(top: rateSeven, color: Colors.green),
            ParallaxWidget(top: rateEight, color: Colors.blue),
            ListView(
              children: <Widget>[
                Container(
                  height: 600,
                  color: Colors.transparent,
                ),
                Container(
                  color: const Color(0xff210002),
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Parallax In",
                        style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.8,
                            color: Color(0xffffaf00)),
                      ),
                      const Text(
                        "Flutter",
                        style: TextStyle(
                            fontSize: 51,
                            letterSpacing: 1.8,
                            color: Color(0xffffaf00)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 190,
                        child: Divider(
                          height: 1,
                          color: Color(0xffffaf00),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Observe the color boxes moving at different speeds with respect to the scroll",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.8,
                          color: Color(0xffffaf00),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 600,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.green,
                          Colors.yellow
                        ])),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key? key,
    required this.top,
    required this.color,
  }) : super(key: key);

  final double top;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: 0,
      left: 0,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.green),
            borderRadius:
                const BorderRadius.all(Radius.circular(10))),
        // child: Image.asset("assets/parallax1/$asset.png",
        //     fit: BoxFit.fill),
      ),
    );
  }
}
