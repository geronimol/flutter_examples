import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key, required this.child, required this.loading, this.processingImage = false});

  final bool loading;
  final bool processingImage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        loading == true
            ? Positioned.fill(
                child: Container(
                  color: Colors.black38,
                  child: processingImage ? const ProcessingImageWidget() : const LoadingWidget(),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}

class ProcessingImageWidget extends StatelessWidget {
  const ProcessingImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 200, child: LinearProgressIndicator()),
            SizedBox(height: 5),
            Text(
              'PROCESSING IMAGE...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2.0,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
