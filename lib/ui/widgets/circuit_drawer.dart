import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/models/wire.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';

class WhiteBoard extends CustomPainter {
  late Circuit circuit;
  CircuitController controller = Get.find();
  Offset offset;
  WhiteBoard({String circuitName = "main", this.offset = Offset.zero}) {
    circuit = controller.loadCircuitData(name: circuitName);
  }

  /// Given a list of wires, this function iterates through them all, painting
  /// with an offset applied to each line painted in order to allow the
  /// "infinite" scrolling effect
  void wirePainter({required Canvas canvas, List<Wire> wires = const []}) {
    for (var wire in wires) {
      canvas.drawLine(
          Offset(wire.origin[0], wire.origin[1]) + offset,
          Offset(wire.end[0], wire.end[1]) + offset,
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

  /// Makes sure that repainting only occurs when changing circuits or while
  /// "scrolling" through the canvas
  @override
  bool shouldRepaint(WhiteBoard oldDelegate) {
    if (oldDelegate.offset != offset ||
        oldDelegate.circuit.name != circuit.name) return true;

    return false;
  }
}
