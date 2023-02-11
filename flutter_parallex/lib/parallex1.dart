import 'package:flutter/material.dart';

/// Basics
/// inspired from
/// https://medium.com/@taydinadnan/flutter-parallax-animasyonu-nas%C4%B1l-yap%C4%B1l%C4%B1r-b1294484547d
/// and
/// https://fidev.io/tickets-challenge-parallax/
class ParallexOne extends StatefulWidget {
  const ParallexOne({Key? key}) : super(key: key);

  @override
  State<ParallexOne> createState() => _ParallexOneState();
}

class _ParallexOneState extends State<ParallexOne> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 30),
                  Text(
                    'Vincent\nvan Gogh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '30 March 1853-29 July 1890',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Vincent Willem van Gogh was a Dutch post-impressionist painter who posthumously became one of the most famous and influential figures in the history of Western art.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    'Highlight Paintings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: PageView.builder(
                      itemCount: paintings.length,
                      controller: pageController,
                      itemBuilder: (context, i) {
                        return Transform.scale(
                          scale: 1,
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(15),
                                  child: Image.asset(
                                    paintings[i]['image'],
                                    height: 370,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(
                                        -pageOffset.abs() + i, 0),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 20,
                                  right: 10,
                                  child: Text(
                                    paintings[i]['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Map> paintings = [
  {
    'image': 'assets/painting6.jpeg',
    'name': 'The Sower',
  },
  {
    'image': 'assets/painting2.jpg',
    'name': 'The Starry Night',
  },
  {
    'image': 'assets/painting3.jpg',
    'name': 'The Potato Eaters',
  },
  {
    'image': 'assets/painting4.jpg',
    'name': 'Irises',
  },
  {
    'image': 'assets/painting5.jpg',
    'name': 'Starry Night Over the Rhône',
  },
  {
    'image': 'assets/painting7.jpg',
    'name': 'Landscape with Snow',
  },
  {
    'image': 'assets/painting8.jpg',
    'name': 'The Night Café',
  },
];
