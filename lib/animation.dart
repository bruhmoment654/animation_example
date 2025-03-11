import 'package:flutter/material.dart';

class ArrowAnimatationWidget extends StatefulWidget {
  const ArrowAnimatationWidget({super.key});

  @override
  State<ArrowAnimatationWidget> createState() => _ArrowAnimatationWidgetState();
}

class _ArrowAnimatationWidgetState extends State<ArrowAnimatationWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: TestCustomPatiner(),
        ),
      ),
    );
  }
}

class TestCustomPatiner extends CustomPainter {
  TestCustomPatiner();

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
        text: const TextSpan(
          text: 'VENOM',
          style: TextStyle(fontSize: 60, color: Colors.black),
        ),
        textDirection: TextDirection.ltr)
      ..layout();

    final textSize = Size(textPainter.width, textPainter.height);

    final center = Offset(size.width / 2, size.height / 2).translate(
      -textSize.width / 2,
      -textSize.height / 2,
    );

    final textRect = center & textSize;

    canvas.saveLayer(textRect, Paint());

    textPainter.paint(canvas, center);

    canvas.saveLayer(textRect, Paint()..blendMode = BlendMode.srcATop);

    canvas.drawPaint(Paint()..color = Colors.red);

    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
