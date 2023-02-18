import 'package:flutter/material.dart';

class BestParallax extends StatelessWidget {
  const BestParallax({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class BestParallaxWidget extends StatefulWidget {
  final List<String> backgroundImages;
  final List<String>? forgroundImages;
  final List<String>? titles;

  const BestParallaxWidget(
      {super.key,
      required this.backgroundImages,
      this.forgroundImages,
      this.titles});

  @override
  State<BestParallaxWidget> createState() =>
      _BestParallaxWidgetState();
}

class _BestParallaxWidgetState extends State<BestParallaxWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
