import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Image;
import 'package:get/get.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/models/gates.dart';
import 'package:logisim_n/domain/models/wiring.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:flutter/services.dart' show rootBundle;

class WhiteBoard extends CustomPainter {
  late Circuit circuit;
  CircuitController controller = Get.find();
  Offset offset;
  WhiteBoard({String circuitName = "main", this.offset = Offset.zero}) {
    circuit = controller.loadCircuitData(name: circuitName);
  }

  /// ImageDrawing learned from here
  /// https://www.youtube.com/watch?v=0xyLan2MwwE&list=PL_FNq7dhGByZl5zvxrSD5cpAB2ovHIoTY&index=5
  void picturePainter(
      {required String asset,
      required Canvas canvas,
      required Offset location}) async {
    /*var data = await rootBundle.load(asset);
    final buffer = data.buffer;
    var bytes = buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    ui.Image image = await decodeImageFromList(bytes);
    canvas.drawImage(
        image, location + Offset(-image.width / 2, 0) + offset, Paint());*/
    // Draw the back of the AND gate (flat edge)
    Paint paint = Paint()..color = Colors.black;
    /*canvas.drawLine(
        Offset(50 * 0.2, 50 * 0.2), Offset(50 * 0.2, 50 * 0.8), paint);
    canvas.drawLine(
        Offset(50 * 0.2, 50 * 0.8), Offset(50 * 0.5, 50 * 0.8), paint);
    canvas.drawLine(
        Offset(50 * 0.2, 50 * 0.2), Offset(50 * 0.5, 50 * 0.2), paint);

    // Draw the curved part of the AND gate
    final rect =
        Rect.fromPoints(Offset(50 * 0.5, 50 * 0.1), Offset(50 * 0.8, 50 * 0.9));
    canvas.drawArc(rect, -3.14159 / 2, 3.14159, false, paint)*/
    final path = Path();

    // Draw the straight back of the AND gate
    path.moveTo(50 * 0.2, 0);
    path.lineTo(50 * 0.2, 50);

    // Draw the curved top of the AND gate
    path.quadraticBezierTo(50 * 0.5, 50 * 1.2, 50 * 0.8, 50);

    // Draw the straight front of the AND gate
    path.lineTo(50 * 0.8, 0);

    // Draw the small circle at the output
    canvas.drawCircle(Offset(50 * 0.9, 50 * 0.5), 8, paint);

    // Draw the input lines
    canvas.drawLine(Offset(0, 50 * 0.25), Offset(50 * 0.2, 50 * 0.25), paint);
    canvas.drawLine(Offset(0, 50 * 0.75), Offset(50 * 0.2, 50 * 0.75), paint);

    // Draw the output line
    canvas.drawLine(Offset(50 * 0.9, 50 * 0.5), Offset(50, 50 * 0.5), paint);

    canvas.drawPath(path, paint);
  }

  /// Given a list of gates, this function iterates through them all, painting
  /// with an offset applied to each image painted in order to allow the
  /// "infinite" scrolling effect
  void gatePainter({required Canvas canvas, List<Gate> gates = const []}) {
    for (var gate in gates) {
      if (gate is AndGate) {
        picturePainter(
            asset: "andgate.png", canvas: canvas, location: gate.location);
      }
    }
  }

  /// Given a list of wires, this function iterates through them all, painting
  /// with an offset applied to each line painted in order to allow the
  /// "infinite" scrolling effect
  void wirePainter({required Canvas canvas, List<Wire> wires = const []}) {
    for (var wire in wires) {
      canvas.drawLine(
          wire.origin + offset,
          wire.end + offset,
          Paint()
            ..color = Colors.black
            ..strokeWidth = 5
            ..style = PaintingStyle.stroke
            ..strokeJoin = StrokeJoin.round);
    }
  }

  /// Given a list of tunnels, this function iterates through them all, painting
  /// with an offset applied to each rect and text painted in order to allow the
  /// "infinite" scrolling effect. The way of handling different directions is
  /// basic at most
  void tunnelPainter(
      {required Canvas canvas, List<Tunnel> tunnels = const []}) {
    for (var tunnel in tunnels) {
      Offset start = tunnel.location + offset;
      Offset end = tunnel.location + offset;
      Offset textLocation = tunnel.location + offset;
      switch (tunnel.direction) {
        case "east":
          textLocation = textLocation + Offset(-tunnel.label.length * 7.5, -10);
          start = start + Offset(-tunnel.label.length * 8, -10);
          end = end + const Offset(0, 10);
          break;
        case "west":
          textLocation = textLocation + const Offset(2, -10);
          start = start + const Offset(0, -10);
          end = end + Offset(tunnel.label.length * 8.5, 10);
          break;
        case "north":
          textLocation = textLocation + Offset(-tunnel.label.length * 4, 5);
          start = start + Offset(-tunnel.label.length * 4.5, 0);
          end = end + Offset(tunnel.label.length * 5, 20);
          break;
        case "south":
          textLocation = textLocation + Offset(-tunnel.label.length * 4, -15);
          start = start + Offset(-tunnel.label.length * 5, -15);
          end = end + Offset(tunnel.label.length * 4, 0);
          break;
      }
      canvas.drawRect(
          Rect.fromPoints(start, end),
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
      TextPainter texter = TextPainter(
          text: TextSpan(text: tunnel.label), textDirection: TextDirection.ltr);
      texter.layout();
      texter.paint(canvas, textLocation);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    wirePainter(canvas: canvas, wires: circuit.wires);
    tunnelPainter(canvas: canvas, tunnels: circuit.tunnels);
    gatePainter(canvas: canvas, gates: circuit.gates);
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
