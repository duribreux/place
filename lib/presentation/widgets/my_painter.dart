import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/entities/pixel.dart';

class MyPainter extends CustomPainter {
  final List<Pixel> pixels;

  MyPainter({required this.pixels});

  @override
  void paint(Canvas canvas, Size size) {
    for (final pixel in pixels) {
      canvas.drawPoints(
        PointMode.points,
        [pixel.offset],
        Paint()
          ..color = pixel.color
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
