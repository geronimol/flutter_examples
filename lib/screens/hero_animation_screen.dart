import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/explicit_animation_widget.dart';

class HeroAnimationScreen extends StatelessWidget {
  const HeroAnimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation'),),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'hero',
              child: Material(
                child: Transform.scale(
                  scale: 3,
                  child: const ExplicitAnimationWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
