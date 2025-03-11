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

  late final Animation<Cat> catAnimation;
  @override
  void initState() {
    super.initState();

    final controller = AnimationController(vsync: this)
      ..repeat(
        period: const Duration(seconds: 1),
        reverse: true
      );

    animation = CurvedAnimation(
        parent: controller, curve: const Cubic(.18, -1.06, 0, .43));

    catAnimation = CatTween(
      begin: const Cat(Colors.orange),
      end: const Cat(Colors.pink),
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, __) {

          return Container(
            width: 200,
            height: 200,
            color: catAnimation.value.color,
            child: Transform.rotate(
              angle: math.pi * animation.value * 2,
              child: const Icon(
                Icons.autorenew,
                size: 100,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Cat {
  final Color? color;
  const Cat(this.color);
}

class CatTween extends Tween<Cat> {
  CatTween({super.begin, super.end});

  @override
  Cat lerp(double t) {
    return Cat(
      Color.lerp(begin?.color, end?.color, t),
    );
  }
}
