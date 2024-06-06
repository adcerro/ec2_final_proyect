import 'package:flutter/material.dart';

class Wire {
  Offset origin;
  Offset end;
  Wire({required this.origin, required this.end});
}

class Tunnel {
  Offset location;
  String label;
  String direction;
  Tunnel({required this.location, this.label = "", this.direction = "west"});
}
