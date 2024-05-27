import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CircuitController controller = Get.find();
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
                if (await controller.openFile()) {
                  Get.toNamed('/circuits');
                } else {
                  Get.snackbar('Error', 'Could not open the file');
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
