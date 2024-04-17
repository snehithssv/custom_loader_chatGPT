import 'dart:math';

import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  ProgressPainter.setnew({
    required this.progress,
    required this.setradius,
    required this.backgroundColor,
    required this.progressStrokeColor,
  });
  final double progress;
  final Color backgroundColor;
  final Color progressStrokeColor;
  final double setradius;
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = setradius - 5;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = setradius;
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = SweepGradient(
      startAngle: 3 * pi / 2,
      endAngle: 7 * pi / 2,
      tileMode: TileMode.repeated,
      colors: [progressStrokeColor, Colors.white],
    );

    final backgroundGradient = SweepGradient(
      startAngle: 3 * pi / 2,
      endAngle: 7 * pi / 2,
      tileMode: TileMode.repeated,
      colors: [Colors.white, progressStrokeColor],
    );

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..shader = backgroundGradient.createShader(rect)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = progressStrokeColor
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
