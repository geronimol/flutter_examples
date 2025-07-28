import 'package:flutter/material.dart';

class AnimatedEyeIcon extends StatelessWidget {
  const AnimatedEyeIcon({super.key, required this.onPressed, required this.obscureText});

  final bool obscureText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: obscureText
            ? Icon(
                Icons.remove_red_eye_outlined,
                key: UniqueKey(),
              )
            : Icon(
                Icons.remove_red_eye,
                // color: themeColor0,
                key: UniqueKey(),
              ),
      ),
    );
  }
}
