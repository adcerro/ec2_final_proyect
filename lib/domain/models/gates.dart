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

class OrGate extends Gate {
  int size;

  OrGate(
      {required String direction, required Offset location, required this.size})
      : super(location: location, direction: direction);
}

class XorGate extends Gate {
  int size;

  XorGate(
      {required String direction, required Offset location, required this.size})
      : super(location: location, direction: direction);
}

class NandGate extends Gate {
  int size;

  NandGate(
      {required String direction, required Offset location, required this.size})
      : super(location: location, direction: direction);
}

class NorGate extends Gate {
  int size;

  NorGate(
      {required String direction, required Offset location, required this.size})
      : super(location: location, direction: direction);
}

class XnorGate extends Gate {
  int size;

  XnorGate(
      {required String direction, required Offset location, required this.size})
      : super(location: location, direction: direction);
}
