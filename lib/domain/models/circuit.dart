import 'package:logisim_n/domain/models/tunnel.dart';
import 'package:logisim_n/domain/models/wire.dart';

class Circuit {
  String name;
  List<Wire> wires;
  List<Tunnel> tunnels;
  Circuit({required this.name, this.wires = const [], this.tunnels = const []});
}
