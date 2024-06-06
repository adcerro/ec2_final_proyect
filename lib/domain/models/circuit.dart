import 'package:logisim_n/domain/models/gates.dart';
import 'package:logisim_n/domain/models/wiring.dart';

class Circuit {
  String name;
  List<Wire> wires;
  List<Tunnel> tunnels;
  List<Gate> gates;
  Circuit(
      {required this.name,
      this.wires = const [],
      this.tunnels = const [],
      this.gates = const []});
}
