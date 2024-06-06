import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class Gate {
  Offset location;
  Gate({required this.location});
}

class AndGate extends Gate {
  String facing;
  int size; // Added size property to the AndGate model

  AndGate({required this.facing, required Offset location, required this.size})
      : super(location: location);
}
