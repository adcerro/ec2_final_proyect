import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Upload .circ file',
            ),
            IconButton(
              onPressed: () async {
                FilePickerResult? rawfile = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['circ']);
                if (rawfile != null) {
                  String text =
                      utf8.decode(rawfile.files.single.bytes!.toList());
                  XmlDocument file = XmlDocument.parse(text);
                  file.findAllElements('circuit').forEach((element) {
                    for (var tags in element.attributes) {
                      print(tags);
                    }
                    for (var properties in element.children) {
                      print(properties);
                    }
                  });
                }
              },
              icon: const Icon(Icons.file_upload_rounded),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
