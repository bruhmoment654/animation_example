import 'package:flutter/material.dart';

class ArrowAnimatationWidget extends StatefulWidget {
  const ArrowAnimatationWidget({super.key});

  @override
  State<ArrowAnimatationWidget> createState() => _ArrowAnimatationWidgetState();
}

class _ArrowAnimatationWidgetState extends State<ArrowAnimatationWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> animation;

  late final Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();

    final controller = AnimationController(vsync: this)
      ..repeat(
        period: const Duration(seconds: 1),
      );

    animation = controller;
    colorAnimation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(animation);

    controller.repeat(reverse: true, period: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: TestCustomPatiner(color: colorAnimation, width: animation),
        ),
      ),
    );
  }
}

class TestCustomPatiner extends CustomPainter {
  final Animation<Color?> color;
  final Animation<double> width;

  TestCustomPatiner({
    required this.color,
    required this.width,
  }) : super(repaint: color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.value ?? Colors.white;

    canvas.drawRect(
      Offset.zero & Size(width.value * size.width, 100),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
