import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Gate {
  Offset location;
  String direction;
  Gate({required this.location, this.direction = "west"});
}

class AndGate extends Gate {
  int size; // Added size property to the AndGate model

  AndGate(
      {required String direction, required Offset location, required this.size})
      : super(location: location, direction: direction);
}
