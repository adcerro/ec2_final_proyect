import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';

class CircuitController extends GetxController {
  late XmlDocument file;
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

  List<String> listCircuits() {
    List<String> circs = [];
    file.findAllElements('circuit').forEach((element) {
      String name = element.attributes.first.toString();
      name = name.substring(6, name.length - 1);
      circs.add(name);
    });
    return circs;
  }

  List<List<Offset>> cables(String circname) {
    List<List<Offset>> wiring = [];
    file.findAllElements('wire').forEach((element) {
      print(element.attributes);
    });
    return wiring;
  }
}
