import 'dart:ui';

import 'package:flutter/material.dart';

class ShaderAnimation extends StatefulWidget {
  const ShaderAnimation({super.key});

  @override
  State<ShaderAnimation> createState() => _ShaderAnimationState();
}

class _ShaderAnimationState extends State<ShaderAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat(reverse: true);

    super.initState();
  }

  Future<FragmentShader> _loadShader(String path) async {
    final fragment = await FragmentProgram.fromAsset(path).catchError((e) {
      debugPrint(e);
    });

    return fragment.fragmentShader();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadShader('assets/test.frag'),
        builder: (_, snapshot) {
          final shader = snapshot.data;
          if (shader == null) return const SizedBox();
    
          return CustomPaint(
            size: MediaQuery.sizeOf(context),
            painter: ShaderPainter(
              animation: controller,
              shader: shader,
            ),
          );
        });
  }
}

class ShaderPainter extends CustomPainter {
  final Animation<double> animation;
  final FragmentShader shader;

  const ShaderPainter({required this.animation, required this.shader})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, animation.value * 10)
      ..setFloat(1, size.width)
      ..setFloat(2, size.height);

    final paint = Paint()..shader = shader;

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'SOME TEXT',
        style: TextStyle(fontSize: 100, foreground: paint),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, Offset.zero);

    // canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
