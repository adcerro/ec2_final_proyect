import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:logisim_n/domain/models/circuit.dart';
import 'package:logisim_n/domain/models/wire.dart';
import 'package:xml/xml.dart';

class CircuitController extends GetxController {
  late XmlDocument file;
  List<Circuit> circuitStorage = [];
  List<String> circuitNames = [];
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

  Circuit loadCircuitData({required String name}) {
    Circuit create = Circuit(name: name);
    for (var circ in circuitStorage) {
      if (circ.name == name) {
        return circ;
      }
    }
    file.findAllElements('circuit').forEach((element) {
      if (element.attributes.first.toString().contains(name)) {
        List<Wire> wires = [];
        for (var element in element.childElements) {
          if (element.name.toString() == "wire") {
            String origin = element.attributes.first.value;
            origin = origin.substring(1, origin.length - 1);
            String end = element.attributes.last.value;
            end = end.substring(1, end.length - 1);
            double xOrigin = double.parse(origin.split(",")[0]);
            double yOrigin = double.parse(origin.split(",")[1]);
            double xEnd = double.parse(end.split(",")[0]);
            double yEnd = double.parse(end.split(",")[1]);
            wires.add(Wire(origin: [xOrigin, yOrigin], end: [xEnd, yEnd]));
          }
        }
        create = Circuit(name: name, wires: wires);
        circuitStorage.add(create);
      }
    });
    return create;
  }

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
}
