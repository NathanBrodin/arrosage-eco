import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedColorContainer extends StatefulWidget {
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  AnimatedColorContainer({
    required this.padding,
    required this.borderRadius,
  });

  @override
  _AnimatedColorContainerState createState() => _AnimatedColorContainerState();
}

class _AnimatedColorContainerState extends State<AnimatedColorContainer> {
  Timer? _timer;
  final _random = Random();
  int _colorIndex = 0;
  List<Color> _colors = [];

  @override
void initState() {
  super.initState();

  _timer = Timer.periodic(
    Duration(milliseconds: _random.nextInt(1700) + 700),
    (Timer timer) => setState(() {
      _colorIndex = _random.nextInt(3);
    }),
  );
}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _colors = [
      Colors.white,
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.primary,
    ];
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: _colors[_colorIndex],
        ),
      ),
    );
  }
}
