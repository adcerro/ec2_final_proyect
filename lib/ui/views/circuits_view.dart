import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:logisim_n/ui/widgets/white_board.dart';
import 'package:xml/xml.dart';
import 'package:file_picker/file_picker.dart';

class CircuitsPage extends StatefulWidget {
  const CircuitsPage({super.key});
  @override
  State<CircuitsPage> createState() => _CircuitsPageState();
}

class _CircuitsPageState extends State<CircuitsPage> {
  CircuitController controller = Get.find();
  List<Widget> displayList() {
    List<Widget> circList = [];
    controller.listCircuits().forEach((element) {
      circList.add(TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () {
            print(element);
          },
          child: Text(element)));
    });
    return circList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('View'),
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.sizeOf(context).width / 9,
              height: MediaQuery.sizeOf(context).height,
              child: ListView(
                shrinkWrap: true,
                children: displayList(),
              )),
          CustomPaint(
            painter: WhiteBoard(),
          )
        ],
      ),
    );
  }
}
