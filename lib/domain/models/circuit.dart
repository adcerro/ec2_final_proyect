import 'package:logisim_n/domain/models/wire.dart';

class Circuit {
  String name;
  List<Wire> wires;
  Circuit({required this.name, this.wires = const []});
}
