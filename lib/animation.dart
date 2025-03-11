import 'dart:math';

import 'package:flutter/material.dart';

class ArrowAnimatationWidget extends StatefulWidget {
  const ArrowAnimatationWidget({super.key});

  @override
  State<ArrowAnimatationWidget> createState() => _ArrowAnimatationWidgetState();
}

class _ArrowAnimatationWidgetState extends State<ArrowAnimatationWidget> {
  double size = 100;
  int selectedColor = 0;
  double radius = 0;

  final colors = const [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => setState(
          () {
            final random = Random();
            size = (random.nextDouble() + 0.1) * 200;
            selectedColor = random.nextInt(colors.length);
            radius = random.nextDouble() * 10;
          },
        ),
        child: AnimatedContainer(
          width: size,
          height: size,
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: colors[selectedColor],
          ),
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
