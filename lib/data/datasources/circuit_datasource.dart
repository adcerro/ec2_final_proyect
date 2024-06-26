import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logisim_n/data/datasources/i_circuit_datasource.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/models/wiring.dart';
import 'package:xml/xml.dart';

import '../../domain/models/gates.dart';

class CircuitDataSource extends ICircuitDataSource {
  late XmlDocument file;
  List<Circuit> circuitStorage = [];
  List<String> circuitNames = [];

  /// This function is responsible for displaying the file picker.
  /// Once a file is chosen it gets the text and parses it to the
  /// XmlDocument type of the xml library
  @override
  Future<bool> openFile() async {
    FilePickerResult? rawfile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['circ']);
    if (rawfile != null) {
      String text = utf8.decode(rawfile.files.single.bytes!.toList());
      file = XmlDocument.parse(text);
      return true;
    }
    return false;
  }

  @override
  Future<bool> clear() async {
    circuitStorage.clear();
    circuitNames.clear();
    file = XmlDocument();
    return true;
  }

  ///This function gets all the circuit tags from the file and extracts their name
  ///then the names are stored locally for performance reasons
  @override
  List<String> listCircuitsNames() {
    if (circuitNames.isEmpty) {
      file.findAllElements('circuit').forEach((element) {
        String name = element.attributes.first.toString();
        name = name.substring(6, name.length - 1);
        circuitNames.add(name);
      });
    }
    return circuitNames;
  }

  /// This function looks for the specific circuit in the controller's
  /// storage, if it's not there, then it creates a circuit extracting the
  /// information from the .circ file and stores it in the circuitStorage Array
  /// Finally (being in the storage or not) it returns the circuit
  @override
  Circuit loadCircuitData({required String name}) {
    Circuit create = Circuit(name: name);
    for (var circ in circuitStorage) {
      if (circ.name == name) {
        return circ;
      }
    }
    void wireSubProcessing({required XmlElement element, required List wires}) {
      String origin = element.attributes.first.value;
      origin = origin.substring(1, origin.length - 1);
      String end = element.attributes.last.value;
      end = end.substring(1, end.length - 1);
      double xOrigin = double.parse(origin.split(",")[0]);
      double yOrigin = double.parse(origin.split(",")[1]);
      double xEnd = double.parse(end.split(",")[0]);
      double yEnd = double.parse(end.split(",")[1]);
      wires
          .add(Wire(origin: Offset(xOrigin, yOrigin), end: Offset(xEnd, yEnd)));
    }

    void tunnelSubProcessing(
        {required XmlElement element, required List tunnels}) {
      String location = element.attributes[1].value;
      List coordinates = location.substring(1, location.length - 1).split(",");
      String label = "";
      String facing = "west";
      for (var subelement in element.childElements) {
        if (subelement.attributes.first.value == "label") {
          label = subelement.attributes.last.value;
        }
        if (subelement.attributes.first.value == "facing") {
          facing = subelement.attributes.last.value;
        }
      }
      tunnels.add(Tunnel(
          direction: facing,
          label: label,
          location: Offset(double.parse(coordinates.first),
              double.parse(coordinates.last))));
    }

    void gateProcessing({required XmlElement element, required List gates}) {
      String location = element.attributes[1].value;
      List coordinates = location.substring(1, location.length - 1).split(",");
      String facing = "east"; // Default facing
      int size = 30; // default size

      for (var subelement in element.childElements) {
        if (subelement.attributes.first.value == "facing") {
          facing = subelement.attributes.last.value;
        }
        if (subelement.attributes.first.value == "size") {
          size = int.parse(subelement.attributes.last.value);
        }
      }
      switch (element.attributes.last.value) {
        case "AND Gate":
          gates.add(AndGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;
        case "OR Gate":
          gates.add(OrGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;
        case "NOT Gate":
          gates.add(NotGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;
        case "XOR Gate":
          gates.add(XorGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;
        case "NAND Gate":
          gates.add(NandGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;

        case "NOR Gate":
          gates.add(NorGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;

        case "XNOR Gate":
          gates.add(XnorGate(
              direction: facing,
              location: Offset(double.parse(coordinates.first),
                  double.parse(coordinates.last)),
              size: size));
          break;
      }
    }

    file.findAllElements('circuit').forEach((element) {
      if (element.attributes.first.toString().contains(name)) {
        List<Wire> wires = [];
        List<Tunnel> tunnels = [];
        List<Gate> gates = [];
        for (var element in element.childElements) {
          if (element.name.toString() == "wire") {
            wireSubProcessing(element: element, wires: wires);
          }
          if (element.attributes.last.value == "Tunnel") {
            tunnelSubProcessing(element: element, tunnels: tunnels);
          }
          if (element.attributes.last.value.contains("Gate")) {
            gateProcessing(element: element, gates: gates);
          }
        }
        create =
            Circuit(name: name, wires: wires, tunnels: tunnels, gates: gates);
        circuitStorage.add(create);
      }
    });
    return create;
  }
}
