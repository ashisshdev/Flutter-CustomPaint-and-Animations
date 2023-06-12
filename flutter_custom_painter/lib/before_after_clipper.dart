import 'package:flutter/material.dart';
// inspired from https://www.cutout.pro/
import 'package:video_player/video_player.dart';

const String rawImage = 'assets/before_after/image_raw.jpg';
const String finalImage = 'assets/before_after/image_processed.png';

const String rawVideo = 'assets/before_after/video_raw.mp4';
const String finalVideo = 'assets/before_after/video_processed.mp4';

class BeforeAfter extends StatefulWidget {
  const BeforeAfter({super.key});

  @override
  State<BeforeAfter> createState() => _BeforeAfterState();
}

class _BeforeAfterState extends State<BeforeAfter> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: h * 0.4,
              width: w,
              child: const Images(),
            ),
            SizedBox(height: h * 0.3, width: w, child: const Videos())
          ],
        ),
      ),
    );
  }
}

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  ValueNotifier<double> videoWidthValue = ValueNotifier(190.0);

  late VideoPlayerController _rawVideoController;
  late Future<void> _initializeRawVideoPlayerFuture;

  late VideoPlayerController _finalVideoController;
  late Future<void> _initializeFinalVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _rawVideoController = VideoPlayerController.asset(rawVideo);
    _initializeRawVideoPlayerFuture = _rawVideoController.initialize();

    _finalVideoController = VideoPlayerController.asset(finalVideo);
    _initializeFinalVideoPlayerFuture = _finalVideoController.initialize();
  }

  @override
  void dispose() {
    _rawVideoController.dispose();
    _finalVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: _initializeRawVideoPlayerFuture,
      builder: (context, rawVideoSnapshot) {
        if (rawVideoSnapshot.connectionState == ConnectionState.done) {
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return FutureBuilder(
            future: _initializeFinalVideoPlayerFuture,
            builder: (context, finalVideoSnapshot) {
              if (finalVideoSnapshot.connectionState == ConnectionState.done) {
                _rawVideoController
                  ..play()
                  ..setLooping(true);
                _finalVideoController
                  ..play()
                  ..setLooping(true);
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      left: 0,
                      child: Center(
                        child: SizedBox(
                          width: w * 0.95,
                          child: ClipPath(
                            child: VideoPlayer(_finalVideoController),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        left: 0,
                        child: Center(
                          child: SizedBox(
                            width: w * 0.95,
                            child: ValueListenableBuilder<double>(
                              valueListenable: videoWidthValue,
                              builder: (context, width, child) {
                                return ClipPath(
                                  clipper: ClipperFromRight(width: width),
                                  child: child,
                                );
                              },
                              child: VideoPlayer(_rawVideoController),
                            ),
                          ),
                        )),
                    ValueListenableBuilder<double>(
                      valueListenable: videoWidthValue,
                      builder: (context, width, child) {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              overlayShape: SliderComponentShape.noOverlay,
                              activeTrackColor: Colors.transparent,
                              inactiveTrackColor: Colors.transparent,
                              thumbShape: CustomSliderThumbShape(
                                  sliderheight: h * 0.4, sliderwidth: width)),
                          child: Slider(
                            min: 0.0,
                            max: w * 0.95,
                            value: width,
                            onChanged: (value) {
                              setState(() {
                                videoWidthValue.value = value;
                              });
                            },
                          ),
                        );
                      },
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  double imageWidthValue = 160;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
            left: 0,
            child: Center(
              child: SizedBox(
                width: w * 0.95,
                child: ClipPath(
                  clipper: ClipperFromRight(width: imageWidthValue),
                  child: Image.asset(
                    rawImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            )),
        Positioned.fill(
          child: Center(
            child: SizedBox(
                width: w * 0.95,
                child: Image.asset(
                  finalImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                )),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              thumbShape: CustomSliderThumbShape(
                  sliderheight: h * 0.4, sliderwidth: imageWidthValue)),
          child: Slider(
            min: 0.0,
            max: w * 0.95,
            value: imageWidthValue,
            onChanged: (value) {
              setState(() {
                imageWidthValue = value;
              });
            },
          ),
        )
      ],
    );
  }
}

class ClipperFromRight extends CustomClipper<Path> {
  final double width;

  ClipperFromRight({required this.width});
  @override
  getClip(Size size) {
    final w = width;
    final h = size.height;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double sliderheight;
  final double sliderwidth;

  CustomSliderThumbShape({
    required this.sliderheight,
    required this.sliderwidth,
    this.thumbRadius = 16.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final radius = thumbRadius;
    final paint = Paint()
      ..color = Colors.white60
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * 1,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      text: '< >',
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );

    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawLine(
        Offset(sliderwidth + 10, 0), Offset(sliderwidth + 10, sliderheight), linePaint);
  }
}
