import 'dart:ui';

class Tunnel {
  Offset location;
  String label;
  String direction;
  Tunnel({required this.location, this.label = "", this.direction = "west"});
}
