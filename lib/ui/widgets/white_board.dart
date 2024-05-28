import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/models/wire.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:logisim_n/ui/views/circuits_view.dart';

class WhiteBoard extends CustomPainter {
  late Circuit circuit;
  CircuitController controller = Get.find();
  WhiteBoard({String circuitName = "main"}) {
    circuit = controller.loadCircuitData(name: circuitName);
  }
  void wirePainter({required Canvas canvas, List<Wire> wires = const []}) {
    for (var wire in wires) {
      canvas.drawLine(
          Offset(wire.origin[0], wire.origin[1]),
          Offset(wire.end[0], wire.end[1]),
          Paint()
            ..color = Colors.black
            ..strokeWidth = 5
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    wirePainter(canvas: canvas, wires: circuit.wires);
  }

  @override
  bool shouldRepaint(WhiteBoard oldDelegate) {
    if (oldDelegate.circuit != circuit) {
      return true;
    }
    return false;
  }
}
