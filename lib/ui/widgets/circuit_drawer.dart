import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/models/tunnel.dart';
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

  /// Given a list of tunnels, this function iterates through them all, painting
  /// with an offset applied to each line painted in order to allow the
  /// "infinite" scrolling effect. The way of handling different directions is
  /// basic at most
  void tunnelPainter(
      {required Canvas canvas, List<Tunnel> tunnels = const []}) {
    for (var tunnel in tunnels) {
      TextPainter texter = TextPainter(
          text: TextSpan(text: tunnel.label), textDirection: TextDirection.ltr);
      texter.layout();
      Offset start = Offset.zero;
      Offset end = Offset.zero;
      Offset textLocation = tunnel.location + offset;
      switch (tunnel.direction) {
        case "east":
          textLocation = textLocation + Offset(-tunnel.label.length * 7.5, -10);
          start =
              tunnel.location + Offset(-tunnel.label.length * 8, -10) + offset;
          end = tunnel.location + const Offset(0, 10) + offset;
          break;
        case "west":
          textLocation = textLocation + const Offset(2, -10);
          start = tunnel.location + const Offset(0, -10) + offset;
          end =
              tunnel.location + Offset(tunnel.label.length * 8.5, 10) + offset;
          break;
        case "north":
          textLocation = textLocation + Offset(-tunnel.label.length * 4, 5);
          start =
              tunnel.location + Offset(-tunnel.label.length * 4.5, 0) + offset;
          end = tunnel.location + Offset(tunnel.label.length * 5, 20) + offset;
          break;
        case "south":
          textLocation = textLocation + Offset(-tunnel.label.length * 4, -15);
          start =
              tunnel.location + Offset(-tunnel.label.length * 5, -15) + offset;
          end = tunnel.location + Offset(tunnel.label.length * 4, 0) + offset;
          break;
      }
      canvas.drawRect(
          Rect.fromPoints(start, end),
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
      texter.paint(canvas, textLocation);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    wirePainter(canvas: canvas, wires: circuit.wires);
    tunnelPainter(canvas: canvas, tunnels: circuit.tunnels);
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
