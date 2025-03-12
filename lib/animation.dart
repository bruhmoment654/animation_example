import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationExample extends StatelessWidget {
  const AnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/animation.json'),
    );
  }
}