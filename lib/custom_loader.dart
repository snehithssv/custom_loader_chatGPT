import 'package:flutter/material.dart';
import 'package:loader_animate/loader_painter.dart';

class CustomLoader extends StatefulWidget {
  final Widget child;

  const CustomLoader({super.key, required this.child});

  @override
  CustomLoaderState createState() => CustomLoaderState();
}

class CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double radius = 50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30),
    )
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          radius = radius + 10;
          _controller.forward(from: 0);
        }
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ProgressPainter.setnew(
            progress: _animation.value,
            setradius: radius,
            backgroundColor: Colors.transparent,
            progressStrokeColor: Theme.of(context).primaryColor,
          ),
          child: widget.child,
        );
      },
    );
  }
}
