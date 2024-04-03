import 'package:flutter/material.dart';
import '../constants.dart';

class ExplicitAnimationWidget extends StatefulWidget {
  const ExplicitAnimationWidget({
    super.key,
  });

  @override
  State<ExplicitAnimationWidget> createState() => _ExplicitAnimationWidgetState();
}

class _ExplicitAnimationWidgetState extends State<ExplicitAnimationWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controllerColor = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.repeat();
    _controllerColor.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controllerColor.value;
        final color = Color.lerp(Colors.black, Colors.yellow, value);
        return Column(
          children: [
            RotationTransition(
              turns: _controller,
              child: Text('🤣', style: TextStyle(fontFamily: 'Noto', fontSize: 50, color: color)),
            ),
            const SizedBox(height: kDefaultPadding),
            Transform.scale(
              scale: (2 * value).clamp(1, 2),
              child: Text('NICE!', style: TextStyle(color: color)),
            ),
          ],
        );
      },
    );
  }
}
