import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomAnimatedContiner extends StatefulWidget {
  final double startWidth;
  final double maxWidth;
  const CustomAnimatedContiner(this.startWidth, this.maxWidth, {super.key});

  @override
  State<StatefulWidget> createState() => _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContiner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _width;
  late double _height;
  late double _maxWidth;
  bool _isAnimating = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _width = widget.startWidth;
    _height = widget.startWidth;
    _maxWidth = widget.maxWidth;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..repeat();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        if (_width <= _maxWidth) {
          _width = _width + 20;
          _height = _height + 20;
          _controller.duration = Duration(
              milliseconds: ((_width >= _width && _width <= _width + 30) ||
                      (_width >= (_maxWidth - 50)))
                  ? 800
                  : 100);
        } else {
          _controller.stop();
          Timer(const Duration(seconds: 1), () {
            setState(() {
              _width = _width - 20;
              _height = _height - 20;
            });
          });
          _timer.cancel();
          _isAnimating = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: AnimatedContainer(
        duration: (_isAnimating)
            ? const Duration(seconds: 1)
            : const Duration(milliseconds: 200),
        width: _width,
        height: _height,
        curve: Curves.fastOutSlowIn,
        child: CustomPaint(
          size: Size(_width, _height),
          painter:
              CustomCirclePainter(Theme.of(context).primaryColor, _isAnimating),
          child: Center(
              child: AnimatedContainer(
            width: (_isAnimating) ? _width + 100 : _width / 2,
            height: (_isAnimating) ? _height + 100 : _height / 2,
            decoration: BoxDecoration(
              border: Border.all(
                color: (_isAnimating)
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
              ),
              color: (_isAnimating)
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 200),
          )),
        ),
      ),
    );
  }
}

class CustomCirclePainter extends CustomPainter {
  final Color color;
  final bool isAnimating;
  CustomCirclePainter(this.color, this.isAnimating);
  @override
  void paint(Canvas canvas, Size size) {
    double centerPoint = size.width / 2;

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 2;

    paint.shader = SweepGradient(
      colors: [Colors.white, color],
      tileMode: TileMode.repeated,
      startAngle: _degreeToRad(200),
      endAngle: _degreeToRad(200 + 360.0),
    ).createShader(
        Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0));

    double startAngle = _degreeToRad(230);
    double sweepAngle = _degreeToRad(360 * 0.8);
    Rect rect = Rect.fromCircle(
        center: Offset(centerPoint, centerPoint), radius: centerPoint);

    final paintColor = Paint()
      ..color = color
      ..strokeWidth = size.width / 2
      ..style = PaintingStyle.stroke;
    canvas.drawArc(rect, startAngle, (isAnimating) ? sweepAngle : 360, false,
        (isAnimating) ? paint : paintColor);
  }

  double _degreeToRad(double degree) => degree * pi / 180;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
