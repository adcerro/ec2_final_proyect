import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logisim_n/ui/controllers/circuits_controller.dart';
import 'package:logisim_n/ui/widgets/circuit_drawer.dart';

class CircuitsPage extends StatefulWidget {
  const CircuitsPage({super.key});
  @override
  State<CircuitsPage> createState() => _CircuitsPageState();
}

class _CircuitsPageState extends State<CircuitsPage> {
  Offset offset = Offset(0, 0);
  String _circuitName = "main";
  CircuitController controller = Get.find();
  List<Widget> displayList() {
    List<Widget> circList = [];
    controller.listCircuitsNames().forEach((element) {
      circList.add(TextButton(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () {
            setState(() {
              _circuitName = element;
            });
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
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) {
            setState(() {
              offset = offset + details.delta;
            });
          },
          child: Row(
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
              Expanded(
                child: CustomPaint(
                  willChange: true,
                  painter:
                      WhiteBoard(circuitName: _circuitName, offset: offset),
                ),
              ),
            ],
          )),
    );
  }
}
