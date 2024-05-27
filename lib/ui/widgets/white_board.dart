import 'dart:ui';

import 'package:flutter/material.dart';

class WhiteBoard extends CustomPainter {
  const WhiteBoard();
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(100, 100),
        Offset(5, 5),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(WhiteBoard oldDelegate) {
    return false;
  }
}
