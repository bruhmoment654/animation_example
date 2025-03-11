import 'package:flutter/material.dart';

import 'dart:math' as math;

class ArrowAnimatationWidget extends StatefulWidget {
  const ArrowAnimatationWidget({super.key});

  @override
  State<ArrowAnimatationWidget> createState() => _ArrowAnimatationWidgetState();
}

class _ArrowAnimatationWidgetState extends State<ArrowAnimatationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> rotateAnimation;
  late final Animation<double> moveAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this)
      ..repeat(
        period: const Duration(seconds: 2),
        reverse: true
      );

    rotateAnimation = CurvedAnimation(
        parent: controller, curve: Curves.easeInOutQuart);

    moveAnimation = Tween<double>(
      begin: 100,
      end: 200,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeInOutQuart),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) => Positioned(
              left: moveAnimation.value,
              child: Transform.rotate(
                angle: math.pi * rotateAnimation.value * 2,
                child: const Icon(
                  Icons.autorenew,
                  size: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
