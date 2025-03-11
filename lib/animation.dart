import 'package:flutter/material.dart';

import 'dart:math' as math;

class ArrowAnimatationWidget extends StatefulWidget {
  const ArrowAnimatationWidget({super.key});

  @override
  State<ArrowAnimatationWidget> createState() => _ArrowAnimatationWidgetState();
}

class _ArrowAnimatationWidgetState extends State<ArrowAnimatationWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    final controller = AnimationController(vsync: this)
      ..repeat(
        period: const Duration(seconds: 1),
      );

    animation = CurvedAnimation(parent: controller, curve:  const Cubic(.18,-1.06,0,.43));

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, __) => Transform.rotate(
          angle: math.pi * animation.value * 2,
          child: const Icon(
            Icons.autorenew,
            size: 100,
          ),
        ),
      ),
    );
  }
}
