import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/explicit_animation_widget.dart';
import 'hero_animation_screen.dart';

class AnimationsScreen extends StatelessWidget {
  const AnimationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
      ),
      body: const SafeArea(
        child: AnimationsWidget(),
      ),
    );
  }
}

class AnimationsWidget extends StatelessWidget {
  const AnimationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Center(
          child: Column(
            children: [
              const TweenAnimationWidget(),
              const SizedBox(height: kDefaultPadding * 2),
              const Text('Explicit Animation', style: TextStyle(decoration: TextDecoration.underline),),
              const SizedBox(height: kDefaultPadding,),
              const Hero(
                tag: 'hero',
                child: Material(child: ExplicitAnimationWidget()),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              const Text('Hero Animation', style: TextStyle(decoration: TextDecoration.underline),),
              const SizedBox(height: kDefaultPadding,),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HeroAnimationScreen())),
                child: const Text('Go Hero!'),
              ),
              const SizedBox(height: kDefaultPadding * 2),
              const AnimatedSwitcherWidget(),
              const SizedBox(height: kDefaultPadding * 2),
              const ContainerAnimationWidget(),
              const SizedBox(height: kDefaultPadding * 2),
              const AnimatedPositionedWidget(),
              const SizedBox(height: kDefaultPadding * 2),
              const DefaultTextStyleAnimationWidget(),
              const SizedBox(height: kDefaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPositionedWidget extends StatefulWidget {
  const AnimatedPositionedWidget({super.key});

  @override
  State<AnimatedPositionedWidget> createState() => _AnimatedPositionedWidgetState();
}

class _AnimatedPositionedWidgetState extends State<AnimatedPositionedWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Positioned Animation',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        SizedBox(
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Positioned.fill(
                child: Center(
                    child: Text(
                  'Surprise!',
                  style: TextStyle(color: Colors.red),
                )),
              ),
              AnimatedPositioned(
                width: selected ? 150.0 : 100.0,
                height: selected ? 50.0 : 100.0,
                top: selected ? 0.0 : 50.0,
                duration: const Duration(seconds: 2),
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      selected ? 'Opened' : 'Closed',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ElevatedButton(
          onPressed: () => setState(() => selected = !selected),
          child: const Text('Animate!'),
        ),
      ],
    );
  }
}

class TweenAnimationWidget extends StatefulWidget {
  const TweenAnimationWidget({super.key});

  @override
  State<TweenAnimationWidget> createState() => _TweenAnimationWidgetState();
}

class _TweenAnimationWidgetState extends State<TweenAnimationWidget> {
  bool showEmoji = false;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    return Column(
      children: [
        const Text(
          'Tween Animation Builder',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 2),
            curve: Curves.bounceOut,
            tween: Tween(begin: 0, end: 1),
            onEnd: () => setState(() => showEmoji = true),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              child: !showEmoji
                  ? const SizedBox(height: 30,)
                  : Text(
                      '🥰',
                      style: textStyle.copyWith(fontFamily: 'Noto', fontSize: 30),
                    ),
            ),
            builder: (context, value, child) {
              return Opacity(
                opacity: value.clamp(0, 1),
                child: Column(
                  children: [
                    Transform.translate(
                      offset: Offset(-200 * (1 - value), 0),
                      child: const Text(
                        'Welcome to ',
                        style: textStyle,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(200 * (1 - value), 0),
                      child: const Text(
                        'Animations Page',
                        style: textStyle,
                      ),
                    ),
                    child ?? const SizedBox.shrink(),
                  ],
                ),
              );
            }),
      ],
    );
  }
}

class AnimatedSwitcherWidget extends StatefulWidget {
  const AnimatedSwitcherWidget({super.key});

  @override
  State<AnimatedSwitcherWidget> createState() => _AnimatedSwitcherWidgetState();
}

class _AnimatedSwitcherWidgetState extends State<AnimatedSwitcherWidget> {
  bool showCircle = true;
  bool isFadeTransition = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Animated Switcher',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        TextButton(
          onPressed: () => setState(() {
            isFadeTransition = !isFadeTransition;
          }),
          child: Text('${isFadeTransition ? 'Fade' : 'Scale'} transition'),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (widget, animation) {
            if (isFadeTransition) {
              return FadeTransition(
                opacity: animation,
                child: widget,
              );
            } else {
              return ScaleTransition(
                scale: animation,
                child: widget,
              );
            }
          },
          child: showCircle
              ? Container(
                  key: UniqueKey(),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
              : Container(
                  key: UniqueKey(),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.black87),
                  ),
                ),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ElevatedButton(
          onPressed: () => setState(() => showCircle = !showCircle),
          child: const Text('Animate!'),
        ),
      ],
    );
  }
}

class ContainerAnimationWidget extends StatefulWidget {
  const ContainerAnimationWidget({super.key});

  @override
  State<ContainerAnimationWidget> createState() => _ContainerAnimationWidgetState();
}

class _ContainerAnimationWidgetState extends State<ContainerAnimationWidget> {
  double height = 50;
  double width = 50;
  Color color = Colors.black87;
  final maxSize = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Container Animation',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: height,
          width: width,
          color: color,
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (height <= maxSize || width <= maxSize) {
                color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
                if (height <= width) {
                  height += 10;
                } else {
                  width += 10;
                }
              }
            });
          },
          child: const Text('Animate!'),
        ),
      ],
    );
  }
}

class DefaultTextStyleAnimationWidget extends StatefulWidget {
  const DefaultTextStyleAnimationWidget({super.key});

  @override
  State<DefaultTextStyleAnimationWidget> createState() => _DefaultTextStyleAnimationWidgetState();
}

class _DefaultTextStyleAnimationWidgetState extends State<DefaultTextStyleAnimationWidget> {
  double fontSize = 20;
  FontWeight? fontWeight;
  Color? color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Default TextStyle Animation',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 400),
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
          child: Text(
            'Animate Me!',
            style: GoogleFonts.lato(),
          ),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (fontSize < 100) {
                fontSize++;
                if (fontSize.toInt().isOdd) {
                  fontWeight = FontWeight.normal;
                  color = Colors.blue;
                } else {
                  fontWeight = FontWeight.w600;
                  color = Colors.cyan;
                }
              }
            });
          },
          child: const Text('Animate!'),
        ),
      ],
    );
  }
}
