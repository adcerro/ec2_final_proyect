import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';

class WhiteBoard extends CustomPainter {
  String circuit;
  WhiteBoard({this.circuit = ""});
  CircuitController controller = Get.find();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(100, 100),
        Offset(5, 5),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke);
    controller.cables(circuit);
  }

  @override
  bool shouldRepaint(WhiteBoard oldDelegate) {
    return false;
  }
}
